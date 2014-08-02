From: Monard Vong <travelingsoul86@gmail.com>
Subject: Re: [PATCH] git-svn: Avoid systematic prompt for client certificate
 when using "git svn branch"
Date: Sat, 02 Aug 2014 15:26:15 +0200
Message-ID: <53DCE6F7.9040405@gmail.com>
References: <254135> <1406219159-4644-1-git-send-email-travelingsoul86@gmail.com> <20140802100719.GA13095@dcvr.yhbt.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Eric Wong <normalperson@yhbt.net>
X-From: git-owner@vger.kernel.org Sat Aug 02 15:26:21 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XDZKG-0007dW-U5
	for gcvg-git-2@plane.gmane.org; Sat, 02 Aug 2014 15:26:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754751AbaHBN0R convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 2 Aug 2014 09:26:17 -0400
Received: from mail-wg0-f50.google.com ([74.125.82.50]:59808 "EHLO
	mail-wg0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754676AbaHBN0Q (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 2 Aug 2014 09:26:16 -0400
Received: by mail-wg0-f50.google.com with SMTP id n12so5514751wgh.33
        for <git@vger.kernel.org>; Sat, 02 Aug 2014 06:26:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=awcyMNBGvolH9bPnTTNvS4//krbrnLG5hGsYjlfQESk=;
        b=fbmgmeQ6pawc7GGgNixJmLv68+nHJZ3mEGp2sE5RBdnyUJv8rcING45Fys0H/O4RGO
         tkOQLbbi8XpNCkJRFIB1jQ+f/+94PsNwdsy/kmBpmnJSNxOiXMpJKwri16ZQrXqwS8C3
         zJGvkEGXZIkNgHND7lh+6LqaTcOyeV5STqUXWx4dyQ761cTsX2rEQelcjZgLI0NFDovu
         +dyDlJKvZUoVWAyzC9DqZI4ic2d3drx4TC995zBqJFLyKM79mFIFU8/SiZSIixKhWrn4
         Ku8205KpWAWOJGHvbXE8U3iPbdBye2OvhrrBjAr44B4oozsAFHA2MmmZNOzwzzEKm848
         nf1A==
X-Received: by 10.194.200.229 with SMTP id jv5mr17573231wjc.90.1406985974812;
        Sat, 02 Aug 2014 06:26:14 -0700 (PDT)
Received: from [127.0.0.1] (tra78-5-88-172-129-43.fbx.proxad.net. [88.172.129.43])
        by mx.google.com with ESMTPSA id di7sm28311887wjb.34.2014.08.02.06.26.13
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sat, 02 Aug 2014 06:26:14 -0700 (PDT)
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:24.0) Gecko/20100101 Thunderbird/24.6.0
In-Reply-To: <20140802100719.GA13095@dcvr.yhbt.net>
X-Antivirus: avast! (VPS 140801-1, 01/08/2014), Outbound message
X-Antivirus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/254696>

Le 02/08/2014 12:07, Eric Wong a =E9crit :
> Thanks.  In the future, it's expected to Cc: anybody who showed inter=
est
> in previous versions of your patch.
>
> Monard Vong <travelingsoul86@gmail.com> wrote:
>> When a client certificate is required to connect to a Subversion rep=
ository,
>> the certificate location and password may be stored in Subversion co=
nfig directory.
>> Commands like "git svn init/fetch/dcommit" do not prompt for client =
certificate/password
>> if the location is set in SVN config file, but "git svn branch" does=
 not use the config
>> directory, resulting in prompting for certificate location/password =
all the time.
> The commit message is probably too long, and needs to be line-wrapped=
=2E
>
> Perhaps something like:
> ---------------------------8<---------------------------
> Subject: [PATCH] git-svn: branch: avoid systematic prompt for cert/pa=
ss
>
> Commands such as "git svn init/fetch/dcommit" do not prompt for clien=
t
> certificate/password if they are stored in SVN config file.  Make "gi=
t
> svn branch" consistent with the other commands, as SVN::Client is
> capable of building its own authentication baton from information in =
the
> SVN config directory.
>
> Signed-off-by: Monard Vong <travelingsoul86@gmail.com>
> ---------------------------8<---------------------------
>
> I can push the above with my Signed-off-by if you are happy with it.
> Thanks again!
Please do, all pleasure is mine, and thanks a lot for your feedback.

Monard
