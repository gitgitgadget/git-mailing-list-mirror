From: Jay Soffian <jaysoffian@gmail.com>
Subject: Re: symlinked working tree gotcha
Date: Mon, 25 Apr 2011 23:41:29 -0400
Message-ID: <BANLkTik8Pn0b9sgejb2Uawkb=J5tYR9MAA@mail.gmail.com>
References: <20110424165825.GA21062@gnu.kitenet.net> <7vpqoajiz0.fsf@alter.siamese.dyndns.org>
 <20110425190938.GA24744@gnu.kitenet.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org
To: Joey Hess <joey@kitenet.net>
X-From: git-owner@vger.kernel.org Tue Apr 26 05:42:08 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QEZA7-0007zN-Qt
	for gcvg-git-2@lo.gmane.org; Tue, 26 Apr 2011 05:42:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932919Ab1DZDmA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 25 Apr 2011 23:42:00 -0400
Received: from mail-iy0-f174.google.com ([209.85.210.174]:42715 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758005Ab1DZDmA (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 25 Apr 2011 23:42:00 -0400
Received: by iyb14 with SMTP id 14so195272iyb.19
        for <git@vger.kernel.org>; Mon, 25 Apr 2011 20:41:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-type;
        bh=5m3TpKG+OlMaGg3uJu/lGX9QDGK8E5b7dq+7eHVUg9Q=;
        b=BUdtFwtnH0Y7Rgpl26oI3Xb3oN+3JWDOyXy7xuG7Vgj2nH0TXb+J7Gya+MlY73ifIJ
         pcjEb3iWVqUvTOrddD+FuG+xZUX2oGeQ9R6R6Ik3RsrUqb/evZXA27gjNxLxnw8wf/rA
         P5cEtDedXbjOf+BW5ja8EuNvaVIuujTcN3Nm0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        b=LmRUjK9xjaqMmCNJ/TrcVgkhEV5wcvusfdsKrABNe6BOSkiiEJ6kn/6nuV1G/txSW3
         ggPdbRIzyTp9okWioClVP6hiaTbNI/itrImIuccIIXp+WANaY6xzu3T4G1lt+NAZxn/n
         FWE+WZ5EEi/lPyAllirWt1boECh+2lefPOFqY=
Received: by 10.42.154.129 with SMTP id q1mr243441icw.316.1303789319108; Mon,
 25 Apr 2011 20:41:59 -0700 (PDT)
Received: by 10.42.218.7 with HTTP; Mon, 25 Apr 2011 20:41:29 -0700 (PDT)
In-Reply-To: <20110425190938.GA24744@gnu.kitenet.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/172063>

On Mon, Apr 25, 2011 at 3:09 PM, Joey Hess <joey@kitenet.net> wrote:
> Hmm, my /bin/pwd does not return "/tmp/foo" when I've cd'd to "/tmp/sym".

A pwd misfeature IMO. Try:

$ pwd -P

You can make -P the default in bash with "shopt -s -o physical"

j.
