From: Jerome Yanga <jerome.yanga@gmail.com>
Subject: Re: git push from client is not updating files on server
Date: Tue, 6 Mar 2012 16:28:06 -0800
Message-ID: <CAC0z1F9sBYCuv_HMCx1ryWLvxZKUcLPS1UUj80ihEesje+SKzg@mail.gmail.com>
References: <CAC0z1F-bGikXZtLnd8d=3G+4okvNqZaxyrLjh4G3YzPpmqyxQA@mail.gmail.com>
	<4F567DC6.4070903@gmail.com>
	<4F567FEF.5000105@gmail.com>
	<CAC0z1F_eyMo4D8E2j15dOFhp-6tZ_ixacB6XcKfNpJategcsXQ@mail.gmail.com>
	<CAC0z1F_LYRkReO1qqcjkWy6Vb3E0_oNo-0kSf15nGfQFAtXpdg@mail.gmail.com>
	<CAC0z1F87ORZQmrZeMGo2suV1fAt-5mAwwpkkV3ZTx0US3AjM8Q@mail.gmail.com>
	<4F569EA8.4050907@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Neal Kreitzinger <nkreitzinger@gmail.com>
X-From: git-owner@vger.kernel.org Wed Mar 07 01:28:16 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S54jm-000302-WA
	for gcvg-git-2@plane.gmane.org; Wed, 07 Mar 2012 01:28:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1031282Ab2CGA2I convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 6 Mar 2012 19:28:08 -0500
Received: from mail-vx0-f174.google.com ([209.85.220.174]:64710 "EHLO
	mail-vx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932682Ab2CGA2H convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 6 Mar 2012 19:28:07 -0500
Received: by vcqp1 with SMTP id p1so4969318vcq.19
        for <git@vger.kernel.org>; Tue, 06 Mar 2012 16:28:06 -0800 (PST)
Received-SPF: pass (google.com: domain of jerome.yanga@gmail.com designates 10.52.90.110 as permitted sender) client-ip=10.52.90.110;
Authentication-Results: mr.google.com; spf=pass (google.com: domain of jerome.yanga@gmail.com designates 10.52.90.110 as permitted sender) smtp.mail=jerome.yanga@gmail.com; dkim=pass header.i=jerome.yanga@gmail.com
Received: from mr.google.com ([10.52.90.110])
        by 10.52.90.110 with SMTP id bv14mr10763283vdb.118.1331080086128 (num_hops = 1);
        Tue, 06 Mar 2012 16:28:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=ZchzAoXNAtDf3PkbwXSHiyL9/t8860l1mPO4gpoHUZI=;
        b=XTMX7nbKeMIIQHdKvO/gmjrzs46jnXMxvs3c8cnGhIWxiY2UFj4CgOMffrkZB8WS46
         z8XiJEoKFxsnudhttk3gLJ7ksnp1TmdEZOfsnYUQ1yWPn1Bx17ZVzs55BModnEfbiBrn
         QtySlS+wuM5QocwgLbe0KJetbHAtrO9+20ba995QrTn19i5AX9J70Yb9BLV9YUS250uA
         Y1vD9bq/J9fEAuCHbRgdaURHtBaxQkiItSGHwPUqmhZ1lMlAXqDk+Cjja8NDAmIZYPxf
         gl+QPJigspqH2cuxy/0RPYUI9Ee20kk9MdmcU7eT6lrNnmTmWAElDgEBC0OLViXcZ9oc
         Xf8g==
Received: by 10.52.90.110 with SMTP id bv14mr9268912vdb.118.1331080086071;
 Tue, 06 Mar 2012 16:28:06 -0800 (PST)
Received: by 10.220.5.210 with HTTP; Tue, 6 Mar 2012 16:28:06 -0800 (PST)
In-Reply-To: <4F569EA8.4050907@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/192419>

The project in Apache's DocumentRoot was created using the following co=
mmand:

"cd /var/www/git
git clone --bare <non-bare working directory> <project>.git"

Hence, I believe that is is bare.  Besides, it does not have .git
folder.  I assumed that when I did this that the non-bare directory
will also be updated when a push is performed via http.

My objective is that I would like the developers to be able to push
via http and these pushes will need to be reflected on the non-bare
working directory as these directories will be used for automated
tests.

Is what I am trying to do even possible?  If so, please share with me a=
 guide.

Thank you in advance.

Regards,
j

On Tue, Mar 6, 2012 at 3:32 PM, Neal Kreitzinger <nkreitzinger@gmail.co=
m> wrote:
> On 3/6/2012 5:07 PM, Jerome Yanga wrote:
>>
>> Is there a way to make git write to the working directory of the
>> central public server?
>>
> In your original post you stated:
>
>
>> From the git client server, I can successfully clone projects in fro=
m
>> the central public Git server using the command below.
>>
>> git clone
>> http://<hostname_of_central_public_git_server>/<Project_name>.git
>
> ".git" extension implies "bare" repo. =A0A bare repo has _no_ working=
 tree.
> =A0Is the repo in question bare or non-bare? =A0If you are not sure, =
then cd to
> the central-repo-dir (ie., the <Project_name>.git you cloned _from_ i=
n your
> example above) and run "git config -l |grep bare". =A0If it says
> "core.bare=3Dtrue" then it is a bare repo.
>
> v/r,
> neal
