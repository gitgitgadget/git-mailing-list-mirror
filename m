From: Charles Bailey <charles@hashpling.org>
Subject: Re: [PATCH v2] Fix definition of ARRAY_SIZE for non-gcc builds
Date: Wed, 24 Jun 2015 23:19:10 +0100
Message-ID: <20150624221910.GA21368@hashpling.org>
References: <1435131867-11361-1-git-send-email-charles@hashpling.org>
 <1435183927-21217-1-git-send-email-charles@hashpling.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Elia Pinto <gitter.spiros@gmail.com>
To: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jun 25 00:19:21 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z7t0q-0004ZL-R8
	for gcvg-git-2@plane.gmane.org; Thu, 25 Jun 2015 00:19:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751854AbbFXWTP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 24 Jun 2015 18:19:15 -0400
Received: from avasout05.plus.net ([84.93.230.250]:33010 "EHLO
	avasout05.plus.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750868AbbFXWTO (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 24 Jun 2015 18:19:14 -0400
Received: from hashpling.plus.com ([212.159.69.125])
	by avasout05 with smtp
	id kNKA1q0072iA9hg01NKBM9; Wed, 24 Jun 2015 23:19:11 +0100
X-CM-Score: 0.00
X-CNFS-Analysis: v=2.1 cv=FZvKv8K6 c=1 sm=1 tr=0
 a=wpJ/2au8Z6V/NgdivHIBow==:117 a=wpJ/2au8Z6V/NgdivHIBow==:17 a=EBOSESyhAAAA:8
 a=0Bzu9jTXAAAA:8 a=J0QyKEt1u0cA:10 a=BHUvooL90DcA:10 a=kj9zAlcOel0A:10
 a=Ew9TdX-QAAAA:8 a=XAFQembCKUMA:10 a=BNFp--SqAAAA:8 a=Aq7FpmWJVsqw8emYOi0A:9
 a=CjuIK1q_8ugA:10 a=INQzUZmD_qcA:10 a=CwwmTeDDTI0A:10 a=e2zW74HbK4YA:10
Received: from charles by hashpling.plus.com with local (Exim 4.84)
	(envelope-from <charles@hashpling.plus.com>)
	id 1Z7t0g-0005ZU-Do; Wed, 24 Jun 2015 23:19:10 +0100
Content-Disposition: inline
In-Reply-To: <1435183927-21217-1-git-send-email-charles@hashpling.org>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/272610>

On Wed, Jun 24, 2015 at 11:12:07PM +0100, Charles Bailey wrote:
> From: Charles Bailey <cbailey32@bloomberg.net>
> 
> The improved ARRAY_SIZE macro uses BARF_UNLESS_AN_ARRAY which is expands
> to a valid check for recent gcc versions and to 0 for older gcc
> versions but is not defined on non-gcc builds.
 
Actually hitting send is a sure fire way to get me spot other errors:
s/which is expands/which expands/
