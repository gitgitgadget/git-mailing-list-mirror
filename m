From: Frans Pop <elendil@planet.nl>
Subject: Re: [PATCH] Staging: arlan: fixed coding style issues in arlan-proc.c (etc...)
Date: Thu, 11 Mar 2010 08:09:50 +0100
Message-ID: <201003110809.52037.elendil@planet.nl>
References: <1268276306-14324-1-git-send-email-andre.beat@gmail.com> <1268278090.1674.37.camel@Joe-Laptop.home> <20100311033248.GA3832@suse.de> <20100311033248.GA3832@suse.de> <1268282459.1674.43.camel@Joe-Laptop.home>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: gregkh@suse.de, git@vger.kernel.org, andre.beat@gmail.com,
	linville@tuxdriver.com, devel@driverdev.osuosl.org,
	linux-kernel@vger.kernel.org
To: Joe Perches <joe@perches.com>
X-From: linux-kernel-owner@vger.kernel.org Thu Mar 11 08:10:10 2010
Return-path: <linux-kernel-owner@vger.kernel.org>
Envelope-to: glk-linux-kernel-3@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <linux-kernel-owner@vger.kernel.org>)
	id 1NpcX1-00039K-4E
	for glk-linux-kernel-3@lo.gmane.org; Thu, 11 Mar 2010 08:10:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752836Ab0CKHJz (ORCPT <rfc822;glk-linux-kernel-3@m.gmane.org>);
	Thu, 11 Mar 2010 02:09:55 -0500
Received: from cpsmtpm-eml101.kpnxchange.com ([195.121.3.5]:60931 "EHLO
	CPSMTPM-EML101.kpnxchange.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752732Ab0CKHJx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Mar 2010 02:09:53 -0500
Received: from aragorn.fjphome.nl ([77.166.180.99]) by CPSMTPM-EML101.kpnxchange.com with Microsoft SMTPSVC(7.0.6001.18000);
	 Thu, 11 Mar 2010 08:09:52 +0100
User-Agent: KMail/1.9.9
In-reply-To: <1268282459.1674.43.camel@Joe-Laptop.home>
Content-Disposition: inline
X-OriginalArrivalTime: 11 Mar 2010 07:09:52.0474 (UTC) FILETIME=[D871F3A0:01CAC0E9]
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/141935>

Joe Perches wrote:
> On Wed, 2010-03-10 at 19:32 -0800, Greg KH wrote:
>> He did, it's a "issue" with git-send-email that if you don't have empty
>> lines, it puts it all on the Subject: line.
> 
> Could you detail a bit more your problem description?

A normal commit description would be:
   <subject>

   <description>

   <signed-off-by>

You get the "running subject" effect if instead you do:
   <subject>
   <description>
   <signed-off-by>

I.e, if you omit an empty line after the subject line.

Cheers,
FJP
