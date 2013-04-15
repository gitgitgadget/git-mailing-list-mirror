From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [RFC/PATCH] push: introduce implicit push
Date: Mon, 15 Apr 2013 15:14:44 +0530
Message-ID: <CALkWK0=aU1e1jh5kbemde8PEbmbUOpAH0jzGZ=0m6c7L3Wz8bg@mail.gmail.com>
References: <1365780835-2853-1-git-send-email-artagnon@gmail.com>
 <7v38uvcrjl.fsf@alter.siamese.dyndns.org> <CALkWK0=-GcOF17Q-y-Aqj0ThX5pPQFrriDqoJ2qsr=CS+wUNGA@mail.gmail.com>
 <7vehed7ilu.fsf@alter.siamese.dyndns.org> <CALkWK0k6bmjFxTSMAutgu2EjWRZ_cyTU9jZ3Er-aaV78T16RtQ@mail.gmail.com>
 <7vppxw335o.fsf@alter.siamese.dyndns.org> <516BA732.4080405@viscovery.net>
 <7vzjx01cqn.fsf@alter.siamese.dyndns.org> <20130415083558.GB2278@serenity.lan>
 <7vk3o416rq.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: John Keeping <john@keeping.me.uk>,
	Johannes Sixt <j.sixt@viscovery.net>,
	Git List <git@vger.kernel.org>, Jeff King <peff@peff.net>,
	Jonathan Nieder <jrnieder@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Apr 15 11:45:30 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1URfyc-0005AF-Ep
	for gcvg-git-2@plane.gmane.org; Mon, 15 Apr 2013 11:45:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752273Ab3DOJp0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 15 Apr 2013 05:45:26 -0400
Received: from mail-ie0-f182.google.com ([209.85.223.182]:58023 "EHLO
	mail-ie0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752193Ab3DOJpZ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Apr 2013 05:45:25 -0400
Received: by mail-ie0-f182.google.com with SMTP id at1so5533322iec.13
        for <git@vger.kernel.org>; Mon, 15 Apr 2013 02:45:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:mime-version:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type;
        bh=bUfrZiZfXEXY9jlHI8Rd9sszyIjQU5Ohi8fkuLeedbE=;
        b=SIgIEpo8kmoSuADuUqS8CJvf669ypadKVPeAv0f03eZdfxTZW0pmJZVwAHCYs2PH5z
         eBCkbrhsr7++5lYKnkDbVLl24pbS9Glb9IxKraCLNr2g08LCsA9njldnkwU2fr6vnGE1
         C3YPfGf0s+TGF7VLZftoq28hYMcDCoYjHCr80rM9uE1TXB+WIbFP1Q0nE07+GbQx6Ds3
         zq1FIE0qERppHYprUbuh5lwu5J/OlE2Ng//SbVD+cVWf+W+Dhp20UpvahN8lxjWv5TrO
         CB/dgnAHLlS+ZjGVWVGIkLLVG3D8rd7apwvWaHbUoUqfj2smBzuAYebdANmkuJpaf0gf
         3tbQ==
X-Received: by 10.42.50.202 with SMTP id b10mr11498081icg.7.1366019124892;
 Mon, 15 Apr 2013 02:45:24 -0700 (PDT)
Received: by 10.64.34.80 with HTTP; Mon, 15 Apr 2013 02:44:44 -0700 (PDT)
In-Reply-To: <7vk3o416rq.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/221212>

Junio C Hamano wrote:
> I do not think it is a red-herring at all. It is not about
> "breaking", but "there will be multiple, conflicting and equally
> plausible expectations" that makes me worry about unnecessary
> confusion.

Well put.

My solution to the problem is to take one of the three alternatives,
and show how it plugs into the larger workflow picture; in this case,
how my proposal fits into the larger picture of a local clone being a
collection of branches, each having little triangles.
