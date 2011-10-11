From: Phil Hord <phil.hord@gmail.com>
Subject: Re: [PATCH] Fix is_gitfile() for files larger than PATH_MAX
Date: Tue, 11 Oct 2011 18:10:32 -0400
Message-ID: <CABURp0rS43hSg00SQQb0rY1R5Jvu4SGHHZr88q8AjV2MH1tkbQ@mail.gmail.com>
References: <alpine.DEB.1.00.1110111424010.32316@s15462909.onlinehome-server.info>
 <7vy5wre0n7.fsf@alter.siamese.dyndns.org> <CABURp0ru7aCW_oUZO8eaFpau5DAHDgwWLqHSL1QMjbUDkqrANg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Oct 12 00:11:14 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RDkXY-0001RS-24
	for gcvg-git-2@lo.gmane.org; Wed, 12 Oct 2011 00:11:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751460Ab1JKWKy convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 11 Oct 2011 18:10:54 -0400
Received: from mail-ww0-f44.google.com ([74.125.82.44]:43918 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750956Ab1JKWKx convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 11 Oct 2011 18:10:53 -0400
Received: by wwf22 with SMTP id 22so100245wwf.1
        for <git@vger.kernel.org>; Tue, 11 Oct 2011 15:10:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=o1wpGq4eiZHHuy7MNVwprMod5Z2VBt7awWFzLZv1jCA=;
        b=SUcpRWAX7KIS6TFCVpPPXgraqED1FgBbOAhXKdGld80YfYTehk4ZTBrdqhbqiJ/P1/
         1xtmUZzNqJMNNktWIgFQQu+sRhzFKpI0rydifypduFEWcVrsg/TQJqv6ENGT1dx3xgTL
         y5EXZ2bkoZpGT8NyIganDKUIYiHj02Sd2g6cw=
Received: by 10.216.157.131 with SMTP id o3mr1468201wek.48.1318371052140; Tue,
 11 Oct 2011 15:10:52 -0700 (PDT)
Received: by 10.216.88.72 with HTTP; Tue, 11 Oct 2011 15:10:32 -0700 (PDT)
In-Reply-To: <CABURp0ru7aCW_oUZO8eaFpau5DAHDgwWLqHSL1QMjbUDkqrANg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/183330>

On Tue, Oct 11, 2011 at 4:58 PM, Phil Hord <phil.hord@gmail.com> wrote:
> I've caught this and have it in
> a re-roll, but I got mired up and haven't submitted it again. =A0I'll
> try to do so today.

On 2nd thought, my other changes are cleanup and not so much a re-roll
of this (except for a couple of code style edits pointed out by Junio,
but I guess those can slide).

I'll send the cleanups and generalities in another patch.

Thanks for the catch, Johannes.

Phil
