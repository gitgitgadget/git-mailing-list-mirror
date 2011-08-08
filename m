From: Shawn Pearce <spearce@spearce.org>
Subject: Re: [RFC] helping smart-http/stateless-rpc fetch race
Date: Mon, 8 Aug 2011 16:33:13 -0700
Message-ID: <CAJo=hJu=nuy8Ws8PP16F=ay-Wp9vAdW_U113WLVCFs4hPQOeQA@mail.gmail.com>
References: <7vbow337gx.fsf@alter.siamese.dyndns.org> <CAJo=hJvdMCyU-5wzy0p1r+QJxXU=DJTE+Mu5G6pk9iAwAD51mA@mail.gmail.com>
 <7vbow01ols.fsf@alter.siamese.dyndns.org> <7vsjpbzv07.fsf@alter.siamese.dyndns.org>
 <CAGdFq_i=8p4jvKo1C=UFpmQyPtUd9JOtr9VW8vn7viC0dQkQmg@mail.gmail.com>
 <20110808230812.GA16974@LK-Perkele-VI.localdomain> <7vty9rtrk4.fsf@alter.siamese.dyndns.org>
 <7vpqkftrhg.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Ilari Liusvaara <ilari.liusvaara@elisanet.fi>,
	Sverre Rabbelier <srabbelier@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Aug 09 01:33:41 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QqZKG-0004z9-Am
	for gcvg-git-2@lo.gmane.org; Tue, 09 Aug 2011 01:33:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753267Ab1HHXdf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 8 Aug 2011 19:33:35 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:38851 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752389Ab1HHXde (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 8 Aug 2011 19:33:34 -0400
Received: by fxh19 with SMTP id 19so5865077fxh.19
        for <git@vger.kernel.org>; Mon, 08 Aug 2011 16:33:33 -0700 (PDT)
Received: by 10.204.139.88 with SMTP id d24mr1808336bku.114.1312846413488;
 Mon, 08 Aug 2011 16:33:33 -0700 (PDT)
Received: by 10.204.124.18 with HTTP; Mon, 8 Aug 2011 16:33:13 -0700 (PDT)
In-Reply-To: <7vpqkftrhg.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/179010>

On Mon, Aug 8, 2011 at 16:26, Junio C Hamano <gitster@pobox.com> wrote:
> Junio C Hamano <gitster@pobox.com> writes:
>
>> A separate option would allow admins to let their clients ask to fetch
>> 4bc5fbf (that is v0.99~2) even if that commit is not at the tip of any ref
>> if they choose to. That is what (1) is about, and people who do not want
>> a separate option needs to argue that it is an unnecessary "feature".
>
> By the way, I personally do not think it is necessary, but as long timers
> on the list may recall, this has come up on the list for a few times.

My feeling is clients aren't likely to do this, or grow this feature
anytime soon, so why add a backend option for it now? Lets add the
feature when the feature is necessary... and right now just fix the
race in smart HTTP.

-- 
Shawn.
