From: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Subject: Re: [PATCH v2 1/8] t/README: Tests are all +x, ./test, not sh ./test
Date: Fri, 2 Jul 2010 01:00:16 +0000
Message-ID: <AANLkTil_sw8r-j_SKMg4L6aDodwVbgwfLzlN15tHArIR@mail.gmail.com>
References: <1278015478-6920-1-git-send-email-avarab@gmail.com>
	<1278015478-6920-2-git-send-email-avarab@gmail.com>
	<7v7hle3gih.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Jul 02 03:00:27 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OUUcF-0004u6-9A
	for gcvg-git-2@lo.gmane.org; Fri, 02 Jul 2010 03:00:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754889Ab0GBBAT convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 1 Jul 2010 21:00:19 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:65192 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752570Ab0GBBAR convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 1 Jul 2010 21:00:17 -0400
Received: by mail-iw0-f174.google.com with SMTP id 7so2639303iwn.19
        for <git@vger.kernel.org>; Thu, 01 Jul 2010 18:00:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=6wjVw0Zw1ZPaP5P+mDeHKb/p4SPoEtnrvpqHavgHGgE=;
        b=BP5Sr4kUw/OAWsFaSxFJKNHkY9MiZ1OBDSNzVebEfOxXoYOKBVgifiNESW7jLZFZKj
         nqsSR6bU6C7IF4ENdnVtXFp9sbC69fJ0leAo0b/WzBsKKVfxhWFUj+IylRNHxZzDMRTT
         aC/ZkmzLhdbB4ESRUZdTkkZJZQu9PvHo8AgJI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=SeT3PA+hvPfIBiOhM5ITuGEgy/W8XVDNFcc+76JPqVpV/+n6PYb1Nu/GSapZdhPcEA
         1BwfIUWSMqq09vox2PB3y0KdgybOC9I903OSt+PKieB/NUpVWjZBFFhyXPnnBxfo909s
         Vpid8uu1JSZEOs6Vy5bHO2AeiMUaKw9a/yAw4=
Received: by 10.231.12.76 with SMTP id w12mr341121ibw.87.1278032416564; Thu, 
	01 Jul 2010 18:00:16 -0700 (PDT)
Received: by 10.231.166.79 with HTTP; Thu, 1 Jul 2010 18:00:16 -0700 (PDT)
In-Reply-To: <7v7hle3gih.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/150094>

On Thu, Jul 1, 2010 at 23:54, Junio C Hamano <gitster@pobox.com> wrote:
> I don't think this is a good change at all. =C2=A0If we spell "sh" ou=
t, people
> with defective shell as the default shell on their system at least wo=
uld
> know that they need to substitute that with "ksh" or "bash" or whatev=
er.

Sure, consider this patch dropped from the series then.
