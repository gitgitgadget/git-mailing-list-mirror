From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 7/8] archive: disregard .gitattributes on working
 directory
Date: Wed, 08 Apr 2009 12:20:29 -0700
Message-ID: <7v3acjkl4y.fsf@gitster.siamese.dyndns.org>
References: <1239185133-4181-1-git-send-email-pclouds@gmail.com>
 <1239185133-4181-2-git-send-email-pclouds@gmail.com>
 <1239185133-4181-3-git-send-email-pclouds@gmail.com>
 <1239185133-4181-4-git-send-email-pclouds@gmail.com>
 <1239185133-4181-5-git-send-email-pclouds@gmail.com>
 <1239185133-4181-6-git-send-email-pclouds@gmail.com>
 <1239185133-4181-7-git-send-email-pclouds@gmail.com>
 <1239185133-4181-8-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Wed Apr 08 21:22:42 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LrdM0-0001Or-Ra
	for gcvg-git-2@gmane.org; Wed, 08 Apr 2009 21:22:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1764471AbZDHTUg convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 8 Apr 2009 15:20:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1764028AbZDHTUg
	(ORCPT <rfc822;git-outgoing>); Wed, 8 Apr 2009 15:20:36 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:54900 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755896AbZDHTUf convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 8 Apr 2009 15:20:35 -0400
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id DFB15A84B4;
	Wed,  8 Apr 2009 15:20:34 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTPSA id D5695A84B3; Wed,
  8 Apr 2009 15:20:30 -0400 (EDT)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 559D2936-2472-11DE-BAFF-BB14ECB1AA3C-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/116114>

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy  <pclouds@gmail.com> writes:

> Some tests in t500-tar-tree.sh depends on in-worktree
> .gitattributes. Fix them too.

s/500/5000/;

You can also consider these as examples of possibly useful use cases of
the current "fix-attributes" feature you are breaking with this patch (=
see
my comments to 3/8).
