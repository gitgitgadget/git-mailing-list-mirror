From: "Mike Ralphson" <mike.ralphson@gmail.com>
Subject: Re: What's in git.git (Oct 2008, #03; Tue, 14)
Date: Wed, 15 Oct 2008 18:25:07 +0100
Message-ID: <e2b179460810151025v684bafd2w8321fc645f5a4e39@mail.gmail.com>
References: <7vej2i7rt9.fsf@gitster.siamese.dyndns.org>
	 <bsftmRx17krWBpVlulipoJEO1fWsD0hZfF3HOZcajX6GV66RKW8W6A@cipher.nrlssc.navy.mil>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Junio C Hamano" <gitster@pobox.com>, git@vger.kernel.org,
	"Arjen Laarhoven" <arjen@yaph.org>, "Jeff King" <peff@peff.net>,
	"Shawn O. Pearce" <spearce@spearce.org>
To: "Brandon Casey" <casey@nrlssc.navy.mil>
X-From: git-owner@vger.kernel.org Wed Oct 15 19:26:24 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KqA8d-0000EH-Kr
	for gcvg-git-2@gmane.org; Wed, 15 Oct 2008 19:26:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752836AbYJORZK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 15 Oct 2008 13:25:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752671AbYJORZK
	(ORCPT <rfc822;git-outgoing>); Wed, 15 Oct 2008 13:25:10 -0400
Received: from qw-out-2122.google.com ([74.125.92.25]:47690 "EHLO
	qw-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752622AbYJORZI (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 15 Oct 2008 13:25:08 -0400
Received: by qw-out-2122.google.com with SMTP id 3so832564qwe.37
        for <git@vger.kernel.org>; Wed, 15 Oct 2008 10:25:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=r2KUMlVtw2JUlmClYj4nWFuhv3z4StTDMfLpUq7sZhc=;
        b=nhybvrQyy4LtQNrfopXd2q2T9ap/ODlBTAj71tMvQHVxYkXmIckV5MmiyOUd3JUtwl
         5o5dda1tRXCYTMCcfJt8SLKOWi2f762btIofFwKLpMgaYma+vUakI3oZ5+tYxOVvFRCe
         HGyh2lonwzEjBBresb/R0kH9s9nLqF4DqEXSM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=iqOBoYTSU3JgcDhlbRDBuVOsDmb4CKc7OgjUmErazpxt2rvNdy5+C1f2lbdRs1ShM2
         4F66iipnjMRTsggFkeeCl0TQuwJI+BSmhw/iW1li1rVWCA0mrrTOaDG7Dme05zu6uSU2
         edCdhFcWbubNweLOq7QRoaGDtTnrWgKwAeO90=
Received: by 10.214.80.18 with SMTP id d18mr1322084qab.46.1224091507213;
        Wed, 15 Oct 2008 10:25:07 -0700 (PDT)
Received: by 10.214.215.10 with HTTP; Wed, 15 Oct 2008 10:25:07 -0700 (PDT)
In-Reply-To: <bsftmRx17krWBpVlulipoJEO1fWsD0hZfF3HOZcajX6GV66RKW8W6A@cipher.nrlssc.navy.mil>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/98288>

2008/10/15 Brandon Casey <casey@nrlssc.navy.mil>:
>  2) Do we want to stick with compat/regex on
>
>      Darwin: Arjen
>     FreeBSD: Jeff
>         AIX: Mike
>
>     now that the builtin funcname patterns have been converted to Extended
>     Regular Expressions?

Thanks for the reminder, I'd been meaning to recheck this. It appears
that AIX doesn't require compat/regex now with the eregexes, so:

Tested-as-no-longer-required-by: Mike Ralphson <mike@abacus.co.uk>

Though I've just noticed my test counts don't actually add up...

fixed   1
success 3555
failed  0
broken  1
total   3559

8-)

Mike
