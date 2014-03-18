From: David Kastrup <dak@gnu.org>
Subject: Re: [PATCH 4/4] gc --aggressive: three phase repacking
Date: Tue, 18 Mar 2014 08:38:46 +0100
Message-ID: <87d2hkvtvd.fsf@fencepost.gnu.org>
References: <1394976904-15395-1-git-send-email-pclouds@gmail.com>
	<1394976904-15395-6-git-send-email-pclouds@gmail.com>
	<20140318045050.GB8240@sigill.intra.peff.net>
	<20140318050727.GA14769@sigill.intra.peff.net>
	<CACsJy8DZsH_2CpaUUpc5xyunHD42CN24m6Mb+9vsKyaRqJ6q3w@mail.gmail.com>
	<CACsJy8BhqiZcJY2=VWzu=ENGbbigWAQXQh3fYxLEtUxDd=8Z+Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Jeff King <peff@peff.net>, Git Mailing List <git@vger.kernel.org>
To: Duy Nguyen <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Tue Mar 18 08:38:54 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WPobt-0006l9-5r
	for gcvg-git-2@plane.gmane.org; Tue, 18 Mar 2014 08:38:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752266AbaCRHis (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 18 Mar 2014 03:38:48 -0400
Received: from fencepost.gnu.org ([208.118.235.10]:58141 "EHLO
	fencepost.gnu.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751534AbaCRHir (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 18 Mar 2014 03:38:47 -0400
Received: from localhost ([127.0.0.1]:57182 helo=lola)
	by fencepost.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dak@gnu.org>)
	id 1WPobm-0003po-HX; Tue, 18 Mar 2014 03:38:46 -0400
Received: by lola (Postfix, from userid 1000)
	id 1F12AEACDA; Tue, 18 Mar 2014 08:38:46 +0100 (CET)
In-Reply-To: <CACsJy8BhqiZcJY2=VWzu=ENGbbigWAQXQh3fYxLEtUxDd=8Z+Q@mail.gmail.com>
	(Duy Nguyen's message of "Tue, 18 Mar 2014 13:19:54 +0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3.50 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/244337>

Duy Nguyen <pclouds@gmail.com> writes:

> On Tue, Mar 18, 2014 at 12:16 PM, Duy Nguyen <pclouds@gmail.com> wrote:
>> But I think it's orthogonal to gc --aggressive improvement.
>
> There's another reason that improving gc may be a good idea (or not).
> It depends on how other git implementations handle long delta chains.

"Other git implementations" including current installations that have a
half-life of at last a year.

-- 
David Kastrup
