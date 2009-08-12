From: skillzero@gmail.com
Subject: Re: [RFC PATCH v3 7/8] Support sparse checkout in unpack_trees() and 
	read-tree
Date: Tue, 11 Aug 2009 21:59:17 -0700
Message-ID: <2729632a0908112159y13a088a1w5580cf042a40bec8@mail.gmail.com>
References: <1250005446-12047-1-git-send-email-pclouds@gmail.com>
	 <1250005446-12047-4-git-send-email-pclouds@gmail.com>
	 <1250005446-12047-5-git-send-email-pclouds@gmail.com>
	 <1250005446-12047-6-git-send-email-pclouds@gmail.com>
	 <1250005446-12047-7-git-send-email-pclouds@gmail.com>
	 <1250005446-12047-8-git-send-email-pclouds@gmail.com>
	 <2729632a0908111418m57e03d8as9c122cbb52efc21a@mail.gmail.com>
	 <m3ab26owub.fsf@localhost.localdomain>
	 <2729632a0908111503i7f035c1aw4e84151eab821006@mail.gmail.com>
	 <fcaeb9bf0908111830n50bd4733h5033c6f13a45999@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Jakub Narebski <jnareb@gmail.com>, git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Junio C Hamano <gitster@pobox.com>
To: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Wed Aug 12 06:59:48 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Mb5wB-0004la-6H
	for gcvg-git-2@gmane.org; Wed, 12 Aug 2009 06:59:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752188AbZHLE7R (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 12 Aug 2009 00:59:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752124AbZHLE7R
	(ORCPT <rfc822;git-outgoing>); Wed, 12 Aug 2009 00:59:17 -0400
Received: from qw-out-2122.google.com ([74.125.92.27]:15206 "EHLO
	qw-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751996AbZHLE7Q (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 12 Aug 2009 00:59:16 -0400
Received: by qw-out-2122.google.com with SMTP id 8so1602520qwh.37
        for <git@vger.kernel.org>; Tue, 11 Aug 2009 21:59:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=GZmKZSIwNd0ZsVcBWBzLGgXwH41G0myi9i357buX3PM=;
        b=cPn+cXDWn2+bnb0aJ+HXUkewpzdItSKGD6LkT897MW0jjMgn75In6RDZYhI6kqAXcd
         TduGIfF5RjorD/bFxzBhS/q4keW7zJPF9h0GvIgOhQnOnQzfnucqzszX4NBWcc/4z3ab
         zUWlWIzdOy7aBArsoqhdHkIfatERIMQ4X6+lg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=ETxjW7GOeYEekzB7FtVskvK19TBkNylAI5ksKgnSoZC4HCVbe9LmzWm9WEgsqzFlnQ
         0Vvlk0l5tVTIbO7aVuuBUAM7ER7dyrO/7V3s0TF3B04HX5d3MMMtH/zSiMBL9PZ8YzXw
         3Jp+4ZLAHMv0DtpWWfnC3TLXUm8SqIPhjL+zQ=
Received: by 10.224.19.207 with SMTP id c15mr4604538qab.69.1250053157575; Tue, 
	11 Aug 2009 21:59:17 -0700 (PDT)
In-Reply-To: <fcaeb9bf0908111830n50bd4733h5033c6f13a45999@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/125655>

On Tue, Aug 11, 2009 at 6:30 PM, Nguyen Thai Ngoc Duy<pclouds@gmail.com> wrote:

> I think it's as easy as writing exclude patterns once you figure out '*'.

That solves it for me. Thanks.
