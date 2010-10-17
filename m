From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH v2 0/8] fix push --progress over file://, git://, etc.
Date: Sat, 16 Oct 2010 19:51:07 -0500
Message-ID: <20101017005107.GH20883@burratino>
References: <AANLkTimo=Bd_XGvX=TPzVsds3xQGy9126+7Qg+zvk=d2@mail.gmail.com>
 <1287254223-4496-1-git-send-email-rctay89@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>, Jeff King <peff@peff.net>,
	Chase Brammer <cbrammer@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
To: Tay Ray Chuan <rctay89@gmail.com>
X-From: git-owner@vger.kernel.org Sun Oct 17 02:54:51 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P7HWQ-00009H-Fl
	for gcvg-git-2@lo.gmane.org; Sun, 17 Oct 2010 02:54:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757062Ab0JQAyl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 16 Oct 2010 20:54:41 -0400
Received: from mail-yw0-f46.google.com ([209.85.213.46]:39559 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757022Ab0JQAyk (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 16 Oct 2010 20:54:40 -0400
Received: by ywi6 with SMTP id 6so894787ywi.19
        for <git@vger.kernel.org>; Sat, 16 Oct 2010 17:54:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=SdPsV+RN2GoITwneIWxqRuUovhlDASoIZ2HZxwAWAgE=;
        b=JVSaND4XC7wYRZLya7wO7YpUqIiiT0PU+MO3euCp+GuTzRn1MsIBRUT14gjbnRXos+
         2s++KM5oMiNCYd27BDOaIHxa6Z49fGjTMgd7uCdPrOvLpRRbeGuO4+6hm122u1BsyOvK
         bkorN4zdwCgZF5nOqvcLOantGrdFL8Jf0i7Fk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=grTX/eq920wf1QnWgpMwnPCrFRrcjAbjDpJXGC9fkd2X+0BnGnZJN5pD5ude1OzFff
         WrqlTsHL20DWyt68xa6JpMIfHFA+SLuDYS6z/XtoeR5WLlc/+7+bdvG5boVRYDTqFF1O
         y5dssudL49I/FXcffZVkBNLAhXzhI0YwY6TQc=
Received: by 10.236.109.179 with SMTP id s39mr3652958yhg.59.1287276879905;
        Sat, 16 Oct 2010 17:54:39 -0700 (PDT)
Received: from burratino (adsl-68-255-106-176.dsl.chcgil.sbcglobal.net [68.255.106.176])
        by mx.google.com with ESMTPS id x21sm11190377yhc.35.2010.10.16.17.54.38
        (version=SSLv3 cipher=RC4-MD5);
        Sat, 16 Oct 2010 17:54:39 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1287254223-4496-1-git-send-email-rctay89@gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/159182>

Tay Ray Chuan wrote:

> Jeff King (3):
>   tests: factor out terminal handling from t7006
>   tests: test terminal output to both stdout and stderr
>   push: pass --progress down to git-pack-objects
> 
> Jonathan Nieder (3):
>   test-lib: allow test code to check the list of declared prerequisites
>   test_terminal: catch use without TTY prerequisite
>   test_terminal: give priority to test-terminal.perl usage
> 
> Tay Ray Chuan (2):
>   t5523-push-upstream: add function to ensure fresh upstream repo
>   t5523-push-upstream: test progress messages

I've sent some comments on patches 5 (give priority..) and 7 (test
progress messages).  Except as mentioned,

Reviewed-by: Jonathan Nieder <jrnieder@gmail.com>

Thanks for cleaning up the test_terminal mess.
