From: "James P. Howard, II" <jh@jameshoward.us>
Subject: Re: [PATCH] Add commit.infodisplay option to give message editor
 empty file
Date: Sat, 5 Dec 2009 18:09:03 -0500
Message-ID: <20091205230903.GA3816@thermopylae.local>
References: <1259967879-65517-1-git-send-email-jh@jameshoward.us>
 <7vpr6t6fnz.fsf@alter.siamese.dyndns.org>
 <20091205154753.GA3717@thermopylae.local>
 <20091205162827.GA9584@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sun Dec 06 00:09:15 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NH3kY-00046E-VY
	for gcvg-git-2@lo.gmane.org; Sun, 06 Dec 2009 00:09:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757510AbZLEXJD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 5 Dec 2009 18:09:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757490AbZLEXJD
	(ORCPT <rfc822;git-outgoing>); Sat, 5 Dec 2009 18:09:03 -0500
Received: from qw-out-2122.google.com ([74.125.92.27]:8507 "EHLO
	qw-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757475AbZLEXJC (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 5 Dec 2009 18:09:02 -0500
Received: by qw-out-2122.google.com with SMTP id 3so689520qwe.37
        for <git@vger.kernel.org>; Sat, 05 Dec 2009 15:09:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:sender:date:from:to:cc
         :subject:message-id:references:mime-version:content-type
         :content-disposition:in-reply-to:user-agent;
        bh=FVA3rZDlPkn+2W1XrKWaQBL/YmNEerz0iGFPmZ9B4XE=;
        b=J7Rnr44swc94gFJOQEtYcDXxGI9DSZFXzTQPrJvuDRex1+EnC6DB+o5WPQ9cm50+OT
         gTXXARbwJKKzW8Vc0WaADRYpsDA03N/xwbh/txFfMDV2LzobZUpwFpMSbonPF0Ctt4T2
         5P2MQNIt6Feg8dMWgapojFD+G/Xeijo40VWU4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=VhgKk2hbKFAalQPBFLOzhvg1Egjklp1leTChAIEELe8dWC68TKrME4GzzdNG66IBj+
         f6sjbpsxsI6mTaHXKinGpeldC9c6zTZZ6I6GmxFI+mQOBk14iANwFDGDD57fcxhU5YRj
         LKbJzN/QcDjkBg36xSaUTQC7ESKeZddsB+p0c=
Received: by 10.224.82.85 with SMTP id a21mr2620862qal.108.1260054547072;
        Sat, 05 Dec 2009 15:09:07 -0800 (PST)
Received: from thermopylae.local (c-68-57-75-220.hsd1.va.comcast.net [68.57.75.220])
        by mx.google.com with ESMTPS id 20sm2634117qyk.9.2009.12.05.15.09.05
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 05 Dec 2009 15:09:05 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20091205162827.GA9584@sigill.intra.peff.net>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/134635>

On Sat, Dec 05, 2009 at 11:28:27AM -0500, Jeff King wrote:

> If the latter, I think we would be better served by an option to simply
> turn off the template. Then that is also helpful for the case of people
> using decent editors, but who don't want to waste the CPU time on
> generating the template information (which can be substantial for things
> like media repositories).

Actually, I find this a reasonable solution for both cases and would be
willing to reimplment my change this way, as it meets my needs and would
be useful to others.  The only question I have is, what should variable/
command line option be called?

James

-- 
James P. Howard, II, MPA MBCS
jh@jameshoward.us
