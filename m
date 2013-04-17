From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: Re: [PATCH 1/3] fast-export: add --signed-tags=warn-strip mode
Date: Tue, 16 Apr 2013 22:02:21 -0700
Message-ID: <CAGdFq_gx0W-TfLpVMbXHiZbDmMK49aUMubKmn08nF3U+AE5_RA@mail.gmail.com>
References: <CAGdFq_g+kk-Fy1fcV6D5x4kroRXX63T8wjKNUqqfu39wUkSO6A@mail.gmail.com>
 <cover.1365936811.git.john@keeping.me.uk> <8716b887972b0eb1671afd2692416efd588f7d1d.1365936811.git.john@keeping.me.uk>
 <CAGdFq_jCO_+qj87rtcFyFG2tot8Ah2706X2dm82F6=GBV-g6nw@mail.gmail.com>
 <7vk3o3nktl.fsf@alter.siamese.dyndns.org> <CAGdFq_gCeE8gRxmRYkGkm+kn6_Vo22_8g7+eLMuj-+pKjJjPcA@mail.gmail.com>
 <20130416084252.GK2278@serenity.lan> <7vtxn5hieo.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: John Keeping <john@keeping.me.uk>, Git List <git@vger.kernel.org>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Florian Achleitner <florian.achleitner.2.6.31@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Apr 17 07:03:23 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1USKWe-0004D7-Fi
	for gcvg-git-2@plane.gmane.org; Wed, 17 Apr 2013 07:03:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755175Ab3DQFDE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 17 Apr 2013 01:03:04 -0400
Received: from mail-ie0-f176.google.com ([209.85.223.176]:64252 "EHLO
	mail-ie0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753330Ab3DQFDC (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 17 Apr 2013 01:03:02 -0400
Received: by mail-ie0-f176.google.com with SMTP id x14so1456932ief.7
        for <git@vger.kernel.org>; Tue, 16 Apr 2013 22:03:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:mime-version:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type;
        bh=Cyye+BkIlQmNEDOW/876pgflEAfQVXTKiQMv4OlqHIw=;
        b=sVN3JWEQkgM8zTcdb891uv8IkgwuQNBOsSFek3wl9OAXimp/MlbI+iC+xAIVgZeXxH
         TobuSiYrD1rlJ0mBUbaOffP1la5xwr6i07W7WBz6U5zARaBdAPYHfhrfWXutxNFnI/0W
         A7whdcyHSXIpmd3+IVS9xoEqR/3e/hL5R8Z3No9PF+X+NdwFxsH4DLdA3fUy7Tqnb2iP
         V9COAycoRO0KDGcTuD7lAgmgdBz/jEKrlfwvNSzIf3djr1bB7W6GQ+Nds3zGujforRM9
         COJM0Em0fK4W3JH645rPz3aAbNM/dK4BkgM5X3sjEguKyAboCdaAdObL/CpJ4N/64OBB
         8Q8g==
X-Received: by 10.50.55.8 with SMTP id n8mr3131579igp.28.1366174981363; Tue,
 16 Apr 2013 22:03:01 -0700 (PDT)
Received: by 10.50.157.229 with HTTP; Tue, 16 Apr 2013 22:02:21 -0700 (PDT)
In-Reply-To: <7vtxn5hieo.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/221505>

On Tue, Apr 16, 2013 at 9:48 PM, Junio C Hamano <gitster@pobox.com> wrote:
> That is a valid point. Nobody has complained that the current
> warning is too noisy, so perhaps the patch is good as-is?

Ah, hadn't realized that. Probably fine then.

--
Cheers,

Sverre Rabbelier
