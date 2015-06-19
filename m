From: Charles Bailey <charles@hashpling.org>
Subject: Re: [PATCH 2/3] Move unsigned long option parsing out of
 pack-objects.c
Date: Fri, 19 Jun 2015 12:06:04 +0100
Message-ID: <20150619110604.GA4562@hashpling.org>
References: <1434705059-2793-1-git-send-email-charles@hashpling.org>
 <1434705059-2793-3-git-send-email-charles@hashpling.org>
 <69265919.629073.1434711805415.JavaMail.zimbra@ensimag.grenoble-inp.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Remi Galan Alfonso <remi.galan-alfonso@ensimag.grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Fri Jun 19 13:06:19 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z5u7f-0001HX-S7
	for gcvg-git-2@plane.gmane.org; Fri, 19 Jun 2015 13:06:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751794AbbFSLGH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 19 Jun 2015 07:06:07 -0400
Received: from avasout06.plus.net ([212.159.14.18]:40815 "EHLO
	avasout06.plus.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750819AbbFSLGG (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 19 Jun 2015 07:06:06 -0400
Received: from hashpling.plus.com ([212.159.69.125])
	by avasout06 with smtp
	id iB641q0072iA9hg01B65nf; Fri, 19 Jun 2015 12:06:05 +0100
X-CM-Score: 0.00
X-CNFS-Analysis: v=2.1 cv=foEhHwMf c=1 sm=1 tr=0
 a=wpJ/2au8Z6V/NgdivHIBow==:117 a=wpJ/2au8Z6V/NgdivHIBow==:17 a=EBOSESyhAAAA:8
 a=0Bzu9jTXAAAA:8 a=J0QyKEt1u0cA:10 a=BHUvooL90DcA:10 a=kj9zAlcOel0A:10
 a=Ew9TdX-QAAAA:8 a=XAFQembCKUMA:10 a=J2gkERRRLc-T7VaIEU4A:9 a=CjuIK1q_8ugA:10
 a=ZvT0AptkhfEA:10 a=WuzKuuAVbI8A:10 a=VxuayAILS94A:10
Received: from charles by hashpling.plus.com with local (Exim 4.84)
	(envelope-from <charles@hashpling.plus.com>)
	id 1Z5u7Y-0001C1-HA; Fri, 19 Jun 2015 12:06:04 +0100
Content-Disposition: inline
In-Reply-To: <69265919.629073.1434711805415.JavaMail.zimbra@ensimag.grenoble-inp.fr>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/272129>

On Fri, Jun 19, 2015 at 01:03:25PM +0200, Remi Galan Alfonso wrote:
> 
> It's trivial matter but the line:
> > + > output 2> output.err &&
> should be written:
> > + >output 2>output.err &&
> 
> It was incorrectly written before but since 
> you are modifying the line, it might be a 
> good thing to change it now.

Yes, I can fold this in. I just changed the wrapping and didn't spot
this style error.
