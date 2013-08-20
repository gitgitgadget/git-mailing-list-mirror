From: Johannes Sixt <j6t@kdbg.org>
Subject: Re: [PATCH] stream_to_pack: xread does not guarantee to read all
 requested bytes
Date: Tue, 20 Aug 2013 20:23:23 +0200
Message-ID: <5213B41B.1080106@kdbg.org>
References: <521333AE.1090506@kdbg.org> <xmqqsiy476h4.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Aug 20 20:23:37 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VBqae-0005YO-CH
	for gcvg-git-2@plane.gmane.org; Tue, 20 Aug 2013 20:23:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751538Ab3HTSXc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 20 Aug 2013 14:23:32 -0400
Received: from bsmtp5.bon.at ([195.3.86.187]:60509 "EHLO bsmtp.bon.at"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1750933Ab3HTSXc (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 20 Aug 2013 14:23:32 -0400
Received: from [10.73.122.231] (178.115.250.231.wireless.dyn.drei.com [178.115.250.231])
	by bsmtp.bon.at (Postfix) with ESMTP id 8F7CBA7ED5;
	Tue, 20 Aug 2013 20:23:29 +0200 (CEST)
User-Agent: Mozilla/5.0 (Windows NT 5.1; rv:17.0) Gecko/20130307 Thunderbird/17.0.4
In-Reply-To: <xmqqsiy476h4.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/232623>

Am 20.08.2013 17:00, schrieb Junio C Hamano:
> I wonder if there are more like this broken caller or xread and/or
> xwrite.

Looking at the grep -C1 output, there are no others.

The only one that looked suspicious was xread in remote-curl.c, but it is 
fine (it just eats all data from the input).

-- Hannes
