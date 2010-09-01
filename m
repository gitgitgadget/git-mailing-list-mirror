From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: [PATCH] Technical details about the index file format.
Date: Wed, 1 Sep 2010 12:52:42 +1000
Message-ID: <AANLkTi=gfGnfwXKFxr-+YmDoEvy5hgdG-xUYsR9AoEK3@mail.gmail.com>
References: <1202711335-12026-1-git-send-email-robin.rosenberg@dewire.com>
	<AANLkTiktRqX+fhFW3mN_b5tnbKzDJY86fLpKVth7RpY9@mail.gmail.com>
	<AANLkTimwGYM-nJTks+E5ez_hGkmE=fcutPKfd8_kfEvs@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Robin Rosenberg <robin.rosenberg@dewire.com>,
	gitster <gitster@pobox.com>, git <git@vger.kernel.org>
To: Sverre Rabbelier <srabbelier@gmail.com>
X-From: git-owner@vger.kernel.org Wed Sep 01 04:53:01 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OqdRZ-00082e-Sw
	for gcvg-git-2@lo.gmane.org; Wed, 01 Sep 2010 04:52:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752039Ab0IACwo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 31 Aug 2010 22:52:44 -0400
Received: from mail-wy0-f174.google.com ([74.125.82.174]:38660 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751496Ab0IACwn (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 31 Aug 2010 22:52:43 -0400
Received: by wyb35 with SMTP id 35so8666069wyb.19
        for <git@vger.kernel.org>; Tue, 31 Aug 2010 19:52:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type;
        bh=31Hk3sHK0QNfA3ZxzVJK95j7hzlRrg4Q2Hzni4QbtrU=;
        b=CY1qKRLFJziuLxUcNRGbrKxKzDV+8mlUAAIrq6+SjQUYAjlkwg63ikuU7mvreebKhY
         S6ZDc6mXuBFeM3r/9CWnl4KYz6T8gqb9rAP+GLXyJRnA8i+gq0+AW1Zo9Fqu8lTbQiVZ
         UUT0EoWwC9YVhbqb5Mp0dV3eaSQNkDXHOhIYQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=p2ltb39IAv/DI418q6DKQnfG3zOVPKl0lMeOMCB1GHByRx2G1/yadfsx15CezAOjDl
         yvmzbByz+5cWUGAoMBlcnwh/rfJiPTT6LfT1y9qTwlQRyRUURtGLZ0qBfK1YNR/CHgyb
         uhDHm9WgGUf3di2BMw21k/7jq26GrwxCIO9eo=
Received: by 10.216.54.202 with SMTP id i52mr7290529wec.40.1283309562335; Tue,
 31 Aug 2010 19:52:42 -0700 (PDT)
Received: by 10.216.184.17 with HTTP; Tue, 31 Aug 2010 19:52:42 -0700 (PDT)
In-Reply-To: <AANLkTimwGYM-nJTks+E5ez_hGkmE=fcutPKfd8_kfEvs@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/155006>

On Wed, Sep 1, 2010 at 12:28 PM, Sverre Rabbelier <srabbelier@gmail.com> wrote:
> Heya,
>
> On Tue, Aug 31, 2010 at 17:12, Nguyen Thai Ngoc Duy <pclouds@gmail.com> wrote:
>> The version could be 3 if extended flags are used.
>
> I suspect you are the person to have most recently messed around with
> the index, and given your corrections above, could you perhaps pick up
> the patch?

Whoa, I did not notice the patch was from 2008. Yes, I'll fix it up and resend.
-- 
Duy
