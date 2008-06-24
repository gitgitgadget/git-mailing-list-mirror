From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: MinGW port pull request
Date: Tue, 24 Jun 2008 15:01:13 +0200
Message-ID: <4860F019.6090309@viscovery.net>
References: <485B6510.3080201@viscovery.net> <7vskv79l37.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>, msysGit <msysgit@googlegroups.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: grbounce-SUPTvwUAAABqUyiVh9Fi-Slj5a_0adWQ=gcvm-msysgit=m.gmane.org@googlegroups.com Tue Jun 24 15:02:23 2008
Return-path: <grbounce-SUPTvwUAAABqUyiVh9Fi-Slj5a_0adWQ=gcvm-msysgit=m.gmane.org@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from yx-out-2122.google.com ([74.125.44.26])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KB8A5-0002IU-1m
	for gcvm-msysgit@m.gmane.org; Tue, 24 Jun 2008 15:02:17 +0200
Received: by yx-out-2122.google.com with SMTP id 22so3137996yxm.63
        for <gcvm-msysgit@m.gmane.org>; Tue, 24 Jun 2008 06:01:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=beta;
        h=domainkey-signature:received:received:x-sender:x-apparently-to
         :received:received:received-spf:authentication-results:received
         :received:message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:x-enigmail-version:content-type
         :content-transfer-encoding:x-spam-score:x-spam-report:sender
         :precedence:x-google-loop:mailing-list:list-id:list-post:list-help
         :list-unsubscribe:x-beenthere;
        bh=DvH7P0TrzmaudM5OfzVSHGgYyBOCiIAc29HeIv13h98=;
        b=PhkLgvG0zlbwgE4w83oCmbA2RLV5PcwAtmwrPejhlhMpfWywKbJ4G0V5hC3z4LATDD
         82UFYeWmQE37UFGC0CcDbkGKJWDKHCh6W6uElXMM99aLaB2zqnkUL6iSxkBuFiNyqUvw
         CHf+hU5mYRQ5Ni6OzR7//Zrh13Lic1QXHMGok=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlegroups.com; s=beta;
        h=x-sender:x-apparently-to:received-spf:authentication-results
         :message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:x-enigmail-version:content-type
         :content-transfer-encoding:x-spam-score:x-spam-report:sender
         :precedence:x-google-loop:mailing-list:list-id:list-post:list-help
         :list-unsubscribe:x-beenthere;
        b=a6eUqWYKQXU0ju3dI2ozRnP1KhwyqYLTF5JclRZWEiFHYW/JjZMZKH6SxNYohgi7DB
         RdyAhafxyYoixInfBhjPZUTuB0PNhEOr1NVwC8O1V/5XBqYp0BMln+nj3a0M8ALkGp9A
         hCEvn1XkVh/MSGJnjIrqicxK9SD7efA/azdUM=
Received: by 10.142.131.5 with SMTP id e5mr545543wfd.2.1214312478607;
        Tue, 24 Jun 2008 06:01:18 -0700 (PDT)
Received: by 10.107.113.4 with SMTP id q4gr2448prm.0;
	Tue, 24 Jun 2008 06:01:18 -0700 (PDT)
X-Sender: j.sixt@viscovery.net
X-Apparently-To: msysgit@googlegroups.com
Received: by 10.100.189.10 with SMTP id m10mr6832168anf.4.1214312477636; Tue, 24 Jun 2008 06:01:17 -0700 (PDT)
Received: from lilzmailso01.liwest.at (lilzmailso01.liwest.at [212.33.55.23]) by mx.google.com with ESMTP id 7si6873573yxg.1.2008.06.24.06.01.16; Tue, 24 Jun 2008 06:01:17 -0700 (PDT)
Received-SPF: neutral (google.com: 212.33.55.23 is neither permitted nor denied by best guess record for domain of j.sixt@viscovery.net) client-ip=212.33.55.23;
Authentication-Results: mx.google.com; spf=neutral (google.com: 212.33.55.23 is neither permitted nor denied by best guess record for domain of j.sixt@viscovery.net) smtp.mail=j.sixt@viscovery.net
Received: from cm56-163-160.liwest.at ([86.56.163.160] helo=linz.eudaptics.com) by lilzmailso01.liwest.at with esmtpa (Exim 4.66) (envelope-from <j.sixt@viscovery.net>) id 1KB893-0000XR-JK; Tue, 24 Jun 2008 15:01:13 +0200
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.42]) by linz.eudaptics.com (Postfix) with ESMTP id 49B8E69F; Tue, 24 Jun 2008 15:01:13 +0200 (CEST)
User-Agent: Thunderbird 2.0.0.6 (Windows/20070728)
In-Reply-To: <7vskv79l37.fsf@gitster.siamese.dyndns.org>
X-Enigmail-Version: 0.95.5
X-Spam-Score: 1.7 (+)
X-Spam-Report: ALL_TRUSTED=-1.8, BAYES_99=3.5
Sender: msysgit@googlegroups.com
Precedence: bulk
X-Google-Loop: groups
Mailing-List: list msysgit@googlegroups.com;
	contact msysgit-owner@googlegroups.com
List-Id: <msysgit.googlegroups.com>
List-Post: <mailto:msysgit@googlegroups.com>
List-Help: <mailto:msysgit-help@googlegroups.com>
List-Unsubscribe: <http://googlegroups.com/group/msysgit/subscribe>,
	<mailto:msysgit-unsubscribe@googlegroups.com>
X-BeenThere: msysgit@googlegroups.com
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/86050>


Junio C Hamano schrieb:
>  * There is an interaction with dr/ceiling topic that is already in 'next'
>    that needs to be resolved before we merge this in 'next'.
> 
> Parked in 'pu' for now but with a broken merge resolution.

Please amend the merge commit by this to get the correct resolution:
minoffset in the MinGW port and ceil_offset in dr/ceiling are used for the
same purpose where always ceil_offset == minoffset-1.

We need to adjust ceil_offset only if longest_ancestor_length() returned
-1 (i.e. "there is no prefix") to skip the drive prefix ("C:"); because if
there was some prefix, then the return value will already have accounted
for the drive prefix.

-- Hannes

diff --git a/setup.c b/setup.c
index 531f852..39f1648 100644
--- a/setup.c
+++ b/setup.c
@@ -382,7 +382,6 @@ const char *setup_git_directory_gently(int *nongit_ok)
 	const char *gitdirenv;
 	const char *gitfile_dir;
 	int len, offset, ceil_offset;
-	int minoffset = 0;

 	/*
 	 * Let's assume that we are in a git repository.
@@ -433,12 +432,10 @@ const char *setup_git_directory_gently(int

 	if (!getcwd(cwd, sizeof(cwd)-1))
 		die("Unable to read current working directory");
-	if (has_dos_drive_prefix(cwd))
-		minoffset = 2;

 	ceil_offset = longest_ancestor_length(cwd, env_ceiling_dirs);
-	if (ceil_offset < minoffset)
-		ceil_offset = minoffset;
+	if (ceil_offset < 0 && has_dos_drive_prefix(cwd))
+		ceil_offset = 1;

 	/*
 	 * Test in the following order (relative to the cwd):
