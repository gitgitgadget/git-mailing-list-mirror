From: Miles Bader <miles@gnu.org>
Subject: Re: [PATCH 6/7] tag: support column output with --column
Date: Thu, 10 Feb 2011 11:54:48 +0900
Message-ID: <87aai4r43r.fsf@catnip.gol.com>
References: <1297178541-31124-1-git-send-email-pclouds@gmail.com>
	<1297178541-31124-7-git-send-email-pclouds@gmail.com>
	<7vvd0sop15.fsf@alter.siamese.dyndns.org>
	<AANLkTinHyX+uiO+Oj3N3NAEjbZmE=vbKsA+C+tQ6B-Db@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Thu Feb 10 03:55:04 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PnMgR-0007eU-Ja
	for gcvg-git-2@lo.gmane.org; Thu, 10 Feb 2011 03:55:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754978Ab1BJCy5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 9 Feb 2011 21:54:57 -0500
Received: from smtp12.dentaku.gol.com ([203.216.5.74]:58449 "EHLO
	smtp12.dentaku.gol.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754215Ab1BJCy5 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 9 Feb 2011 21:54:57 -0500
Received: from 218.33.195.219.eo.eaccess.ne.jp ([218.33.195.219] helo=catnip.gol.com)
	by smtp12.dentaku.gol.com with esmtpa (Dentaku)
	(envelope-from <miles@gnu.org>)
	id 1PnMgD-0004Ys-Lk; Thu, 10 Feb 2011 11:54:49 +0900
Received: by catnip.gol.com (Postfix, from userid 1000)
	id E0A5FDF8A; Thu, 10 Feb 2011 11:54:48 +0900 (JST)
System-Type: x86_64-unknown-linux-gnu
In-Reply-To: <AANLkTinHyX+uiO+Oj3N3NAEjbZmE=vbKsA+C+tQ6B-Db@mail.gmail.com>
	(Nguyen Thai Ngoc Duy's message of "Thu, 10 Feb 2011 09:35:38 +0700")
X-Virus-Scanned: ClamAV GOL (outbound)
X-Abuse-Complaints: abuse@gol.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/166471>

Nguyen Thai Ngoc Duy <pclouds@gmail.com> writes:
>> Hmm, is this robbing streaming output from people who do not care about
>> columnar output?
>
> Yes, but tag list is short enough streaming does not really matter. I
> can check if column mode is active there, if it's not, just printf.

...but it's important to note, I think that in many projects the tag
list is at least long enough that columnar output would be hugely
useful...

-miles

-- 
Custard, n. A vile concoction produced by a malevolent conspiracy of the hen,
the cow, and the cook.
