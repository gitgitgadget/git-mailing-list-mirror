From: "aaron smith" <beingthexemplarylists@gmail.com>
Subject: Re: git push over http - curl PUT error?
Date: Wed, 31 Dec 2008 05:29:53 -0800
Message-ID: <d7ac1a680812310529p6b7e8d88r69755887304d3436@mail.gmail.com>
References: <d7ac1a680812310210r25795e66x35601059103892d7@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Dec 31 14:31:18 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LI1AK-0003jE-Nm
	for gcvg-git-2@gmane.org; Wed, 31 Dec 2008 14:31:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754923AbYLaN3z (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 31 Dec 2008 08:29:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753501AbYLaN3z
	(ORCPT <rfc822;git-outgoing>); Wed, 31 Dec 2008 08:29:55 -0500
Received: from wf-out-1314.google.com ([209.85.200.168]:55811 "EHLO
	wf-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753003AbYLaN3z (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 31 Dec 2008 08:29:55 -0500
Received: by wf-out-1314.google.com with SMTP id 27so5801967wfd.4
        for <git@vger.kernel.org>; Wed, 31 Dec 2008 05:29:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=C7I+W/lY6Zzbjxp0Y6eLcISn5elNoWIBU8Q39DBX/3E=;
        b=D358XyBIZzo5L1CXUbNlfdn6IVBXQI9rmKbK6he8FDsjrW61lnG5AaHWDAxzHxTuFD
         dmYAKtYU0DjzAIuLShse7oiFmYXfCTBmWSGQsGeS60WNepDxKu6xlLDteKQ31Y4FHkd+
         x/ColGsFk1NU5gUsa30940kWkEKplgW6FWj84=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=a9PO8jVKWg21g1WYQPRER5AEu6yl0wqqdz4kyNJEeMqkvZ0ix1Hp3vjdsKfyY+JQqg
         exWF5BInLyXxpHXLZB9i8RldkDE+cUMlBITOpuUfGcvcvZXIqUr64NZMBO0uHfrRp6+8
         5adyMovEMBo33ZZI9OvhEmM/R17b4b8GdGOb4=
Received: by 10.142.214.11 with SMTP id m11mr6514280wfg.279.1230730193533;
        Wed, 31 Dec 2008 05:29:53 -0800 (PST)
Received: by 10.143.115.3 with HTTP; Wed, 31 Dec 2008 05:29:53 -0800 (PST)
In-Reply-To: <d7ac1a680812310210r25795e66x35601059103892d7@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/104270>

ok, duh, i had to use git http-push. What is the difference? Thanks.

On Wed, Dec 31, 2008 at 2:10 AM, aaron smith
<beingthexemplarylists@gmail.com> wrote:
> hey all,
>
> I have one last issue to figure out with git over HTTP. This one is
> seriously stumping me.
>
> I have a bare git repository here: http://codeendeavor.com/guttershark.git/
>
> And I have a local git repo with some files in it, ready to push to
> this public one.
>
> Here's what I do to push to it:
>
> $git push origin master
>
> I then get this output:
> ""
> Fetching remote heads...
>  refs/
>  refs/heads/
>  refs/tags/
> updating 'refs/heads/master'
>  from a08e614723ff57047522511a2130d53010ebe0ca
>  to   2db4bca0d137f4099973387472cf1666d0290e03
>    sending 3 objects
>    done
> Updating remote server info
> PUT error: curl result=22, HTTP code=403
> """
>
> I'm not sure how to get around this.
>
> The git repo permissions are 777, with owner/group apache:apache. I
> have DAV on, and the DavLockDB directive. which seems to all be ok.
> And I don't have any http authentication on it.. or access control
> list for that matter.
>
> Any ideas? Thanks All!
>
