From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH v2 00/45] parse_pathspec and :(glob) magic
Date: Sat, 23 Mar 2013 10:15:28 +0700
Message-ID: <CACsJy8AAyV9FyZ3ff1=FQtHB60Kpz57jrNVuxSVdSaoRO=BCzA@mail.gmail.com>
References: <1363327620-29017-1-git-send-email-pclouds@gmail.com>
 <1363781779-14947-1-git-send-email-pclouds@gmail.com> <7v1ubaeyph.fsf@alter.siamese.dyndns.org>
 <20130321053326.GA17446@duynguyen-vnpc.dek-tpc.internal> <20130321054349.GA18101@duynguyen-vnpc.dek-tpc.internal>
 <7v4ng4br1y.fsf@alter.siamese.dyndns.org> <7vvc8kabhx.fsf@alter.siamese.dyndns.org>
 <20130323031334.GA10484@lanh>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Mar 23 04:16:27 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UJEwV-0004qY-5O
	for gcvg-git-2@plane.gmane.org; Sat, 23 Mar 2013 04:16:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755073Ab3CWDP7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 22 Mar 2013 23:15:59 -0400
Received: from mail-oa0-f42.google.com ([209.85.219.42]:46007 "EHLO
	mail-oa0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754889Ab3CWDP7 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 Mar 2013 23:15:59 -0400
Received: by mail-oa0-f42.google.com with SMTP id i18so5022810oag.29
        for <git@vger.kernel.org>; Fri, 22 Mar 2013 20:15:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:mime-version:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type;
        bh=ScFMaWvrPf4jRtBqKCFjhm1wDyqZJCabdyymXveGhG0=;
        b=Z1NFi+vnrLu1vaQzitc54tuDH5/Mp3Qv3IxsoOgc+kYvHXl97edLWtIbY4OIBvkV9l
         r9FpFEnWHzE0LTZ3EchW1VAejokaPuTYe1r0rIrcijXKcRfEsSZlRPnHyTGkwKqHvVrF
         KMgoALSpFFG0givDsQs876QR8fLquR54Uvp5fekewuoUBfktIkhfCOrhQnprGcSkoKFV
         pZinhFcbaO4q/dY7Okafc3a9VBq5DgOXqCT9VyIklwe7S01S8mJS5QR1xNPQPoRPwtHT
         oKKPv8dDJ7QXYTRYrVTJ4JHLbPwMTf5zPEu7Ti7UpcJju+wR+odJum4Q+r/YyYeV8X6z
         VSwQ==
X-Received: by 10.60.8.197 with SMTP id t5mr4254878oea.4.1364008558445; Fri,
 22 Mar 2013 20:15:58 -0700 (PDT)
Received: by 10.76.27.137 with HTTP; Fri, 22 Mar 2013 20:15:28 -0700 (PDT)
In-Reply-To: <20130323031334.GA10484@lanh>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/218880>

On Sat, Mar 23, 2013 at 10:13 AM, Duy Nguyen <pclouds@gmail.com> wrote:
> which also includes all document bugs reported so far.

s/all/fixes for all/
-- 
Duy
