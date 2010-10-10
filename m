From: Knittl <knittl89@googlemail.com>
Subject: Re: [PATCH] builtin/fetch: print hash of deleted tag when updating
Date: Sun, 10 Oct 2010 15:17:01 +0200
Message-ID: <AANLkTi=VX4gF1jOb_NbzFqwxX4vJaSrmJ29GjnQpUicO@mail.gmail.com>
References: <AANLkTi=KVDRzE3-NW+GTO_CL-KtNZ+BjkErgNKMPPtGf@mail.gmail.com>
 <7vsk0wmbcd.fsf@alter.siamese.dyndns.org> <A612847CFE53224C91B23E3A5B48BAC749BFD33D90@xmail3.se.axis.com>
 <7vfwwv2lb4.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Peter Kjellerstedt <peter.kjellerstedt@axis.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Oct 10 15:21:51 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P4vqZ-0004eR-0B
	for gcvg-git-2@lo.gmane.org; Sun, 10 Oct 2010 15:21:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752052Ab0JJNRX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 10 Oct 2010 09:17:23 -0400
Received: from mail-qy0-f181.google.com ([209.85.216.181]:58487 "EHLO
	mail-qy0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751763Ab0JJNRX (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 10 Oct 2010 09:17:23 -0400
Received: by qyk10 with SMTP id 10so3177486qyk.19
        for <git@vger.kernel.org>; Sun, 10 Oct 2010 06:17:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:received:mime-version:received:in-reply-to
         :references:from:date:message-id:subject:to:cc:content-type;
        bh=JUZF32+zXYd1pL2udBeF9ULcY4kLfLjPF1m7hHnxZa0=;
        b=sJ0pFV4v4VIPFZgrS55hS1DliUglqpZWWQdOHwpNLvZOKZIBL2GCLyth66JWfA/v1t
         DMD18/F2eCK6FWNm9DKUnqBnRahMbNt0p7ef/1D5htd2AQUZx2spvHdJ0PYYI7lkjWRv
         qt4gbqWybKuCeSlu0NBWOTO67rm7U5ZgcuA6A=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        b=q48bkqYXxSdeALga1ZPhGn+a8IJwwxZFcMMbNupmdcalK92ycRcSv7ZCkXPiS+nUBr
         Q7sWUflNh1qg2s0J0Ik5Xh3i55y4X7EdYFlUNXnlKkT5l7TNFlP2rnyWB+mb84aBQdsC
         VWuyTlbtO8za2jvVsI1weD93o8dVjCCxKOQmM=
Received: by 10.224.79.9 with SMTP id n9mr3527559qak.229.1286716642009; Sun,
 10 Oct 2010 06:17:22 -0700 (PDT)
Received: by 10.229.50.7 with HTTP; Sun, 10 Oct 2010 06:17:01 -0700 (PDT)
In-Reply-To: <7vfwwv2lb4.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/158659>

On Mon, Sep 27, 2010 at 6:38 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Peter Kjellerstedt <peter.kjellerstedt@axis.com> writes:
>
>> Shouldn't this behavior of --tags require --force to keep in line
>> with what is described in git tag's manual page?
>
> Sounds sensible, if nobody is already relying on this behaviour.

any updates on this one?

even if we require the --force option it wouldn't hurt if we displayed
the old hash, does it?


-- 
typed with http://neo-layout.org
myFtPhp -- visit http://myftphp.sf.net -- v. 0.4.7 released!
