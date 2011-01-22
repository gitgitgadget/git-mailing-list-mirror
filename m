From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: [PATCH 3/3] setup: always honor GIT_WORK_TREE and core.worktree
Date: Sat, 22 Jan 2011 17:30:51 +0700
Message-ID: <AANLkTim_o9GGWbDFkeGb-va+4dP+StQE6GJyLpSMmV1H@mail.gmail.com>
References: <1290785563-15339-1-git-send-email-pclouds@gmail.com>
 <1290785563-15339-40-git-send-email-pclouds@gmail.com> <20110118074400.GA4185@burratino>
 <7v1v4aknij.fsf@alter.siamese.dyndns.org> <20110119123732.GA23222@burratino>
 <20110119124230.GD23222@burratino> <AANLkTinE5gNZM_HDJq31qs5ARJn-DrO9HW66cszTayPa@mail.gmail.com>
 <20110119193116.GB30618@burratino> <7vpqrssl5d.fsf@alter.siamese.dyndns.org> <7v39omotxg.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Jonathan Nieder <jrnieder@gmail.com>, git@vger.kernel.org,
	Maaartin <grajcar1@seznam.cz>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Jan 22 11:32:02 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PgalF-0002Zk-Vf
	for gcvg-git-2@lo.gmane.org; Sat, 22 Jan 2011 11:32:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752282Ab1AVKbY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 22 Jan 2011 05:31:24 -0500
Received: from mail-ww0-f44.google.com ([74.125.82.44]:49939 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751980Ab1AVKbX (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 22 Jan 2011 05:31:23 -0500
Received: by wwa36 with SMTP id 36so2751813wwa.1
        for <git@vger.kernel.org>; Sat, 22 Jan 2011 02:31:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-type;
        bh=dhnjLOopQCjq8ZRjZDXJc+rATCHv5dRKONuVhag4kE0=;
        b=rZzaQplfOnyKXhhaxAnjGgIsCjBKBFnRIo9cwx9WY/PevwfTyZNLmqprQht3k7dGr6
         isqnJ2QtVT2GAihQyPu7VgEBh3X5JsrYEsLGshLwXIV5++3X8RPlKAlqIMHerAsuw7G3
         Mt9jmmTsujZO6rTWw0tokpdbm3YxYDWJRBLJA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        b=wBgLAh8O0oDFDsErPBUXoLS4EL/23SZHNHeGIgvKZ76CP8U0iYFpOvaPJn7HsZDhVz
         87WJRCM7dRQ0q/SQ6R5qOiCeiFFirM7ntlqiL9c6iDQZ/7/qwmsOz0GW276ebNrvito2
         r5unz4C9gp0kBK5bUIpURGiJcg6QUWtXpjXA8=
Received: by 10.216.176.201 with SMTP id b51mr367701wem.34.1295692282022; Sat,
 22 Jan 2011 02:31:22 -0800 (PST)
Received: by 10.216.63.14 with HTTP; Sat, 22 Jan 2011 02:30:51 -0800 (PST)
In-Reply-To: <7v39omotxg.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/165410>

On Sat, Jan 22, 2011 at 3:58 AM, Junio C Hamano <gitster@pobox.com> wrote:
> I was re-reading this thread, and changed my mind; I think we should have
> this series to avoid unnecessary regression, with or without clarifying
> (5), before 1.7.4 final.

Sorry for late response. If we no longer consider this work-around,
perhaps git.txt and config.txt should be updated to reflect it?
-- 
Duy
