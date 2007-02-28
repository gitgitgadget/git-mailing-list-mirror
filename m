From: Andy Parkins <andyparkins@gmail.com>
Subject: Re: [PATCH 2/2] cvsserver: Remove trailing "\n" from commithash in checkin function
Date: Wed, 28 Feb 2007 08:45:41 +0000
Message-ID: <200702280845.42910.andyparkins@gmail.com>
References: <200702210908.59579.andyparkins@gmail.com> <200702271249.09596.andyparkins@gmail.com> <7vwt239nbm.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <junkio@cox.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Feb 28 09:46:25 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HMKS8-0003aV-DQ
	for gcvg-git@gmane.org; Wed, 28 Feb 2007 09:46:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752067AbXB1Ipt (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 28 Feb 2007 03:45:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752059AbXB1Ipt
	(ORCPT <rfc822;git-outgoing>); Wed, 28 Feb 2007 03:45:49 -0500
Received: from nf-out-0910.google.com ([64.233.182.189]:15255 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752067AbXB1Ips (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 28 Feb 2007 03:45:48 -0500
Received: by nf-out-0910.google.com with SMTP id o25so484809nfa
        for <git@vger.kernel.org>; Wed, 28 Feb 2007 00:45:47 -0800 (PST)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=XdglTvVaf7J1X+icEWxAQTUrJTuzAKYS7/pIJyBS8L7D8Gym65QEOoXzjC9vBbXMDN11SkbX2lfDTvQGKSVN94duME194PyyU+SC9xwflEyhZ7+DsFTScophHVoVUds64eAOvt1EXEJFVx1tHpfdFXkLCX1+Dps2/4McdqsiBYc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=JD2/6UbE6n5djL0qqOYNI/BbRhp+hAg7Sn8zH+Ijzu2NigPlBB56ui+/DM2T/tOnrgQXMM/HofAUwwWMxYipC0yW3E9SjDf+CsGmqluv82INwJ16RnU1ZfgM6HCeIm9cfRS/q2ry3p49jixuMAKdrIjliGz9zR6z43fKtv+J7Ys=
Received: by 10.49.58.13 with SMTP id l13mr3130398nfk.1172652347534;
        Wed, 28 Feb 2007 00:45:47 -0800 (PST)
Received: from 360run094l ( [194.70.53.227])
        by mx.google.com with ESMTP id k23sm5006688nfc.2007.02.28.00.45.44;
        Wed, 28 Feb 2007 00:45:45 -0800 (PST)
User-Agent: KMail/1.9.5
In-Reply-To: <7vwt239nbm.fsf@assigned-by-dhcp.cox.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/40906>

On Tuesday 2007 February 27 23:45, Junio C Hamano wrote:

> Thanks.  Do we need to compensate with a trailing LF in the $log
> line?

Interestingly, no.  I checked that, and the log has always had an unnecessary 
blank line in it - which is of course now removed.


Andy
-- 
Dr Andy Parkins, M Eng (hons), MIET
andyparkins@gmail.com
