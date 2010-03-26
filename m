From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: Tree with leading '0' modes in 1.7.0.3
Date: Fri, 26 Mar 2010 17:26:59 -0500
Message-ID: <20100326222659.GA18369@progeny.tock>
References: <20100326215600.GA10910@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git <git@vger.kernel.org>, mike.lifeguard@gmail.com
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Fri Mar 26 23:27:17 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NvHzo-00012J-CS
	for gcvg-git-2@lo.gmane.org; Fri, 26 Mar 2010 23:27:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754747Ab0CZW1A (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 26 Mar 2010 18:27:00 -0400
Received: from mail-yx0-f191.google.com ([209.85.210.191]:59467 "EHLO
	mail-yx0-f191.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754666Ab0CZW0r (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 26 Mar 2010 18:26:47 -0400
Received: by yxe29 with SMTP id 29so969708yxe.4
        for <git@vger.kernel.org>; Fri, 26 Mar 2010 15:26:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=7kZ0j+BgEJho4I3Mk3TnBz0Iig7ql+8Vz6Bua0u8pbw=;
        b=A1B5UBhIgeP5ayHtyRCANWeFVIBeA8fqa95s0I9hg6AOLufJg/t3mUJppiqyJIWial
         YMaWulyP9Ua004KISOdPfqFnUqPuUC63WbehgB/Vj8WNdh98FHidk1F+qk4LT7jU3f7G
         H3dqA6/DyywO3r95zIvDLDce6Nzga3uBZJnlE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=aAikzatgfW2wrVN12mlo9T2JLAbznVmWZQJxCEiMS2+zRRyUpPKC34uZaLNxyJcdSE
         scHoq46JEmGb6FYYQrbiXKmW5n3OoyvtFyPAhYjk+O8rVLcbh84/MYVVgaXlSf1WXZss
         UJAsv+JMKKNqm+7QO9ygKHeF7H3sXJ4BPHPG0=
Received: by 10.101.184.7 with SMTP id l7mr2615199anp.125.1269642405238;
        Fri, 26 Mar 2010 15:26:45 -0700 (PDT)
Received: from progeny.tock (c-98-212-3-231.hsd1.il.comcast.net [98.212.3.231])
        by mx.google.com with ESMTPS id 20sm1175040iwn.9.2010.03.26.15.26.44
        (version=SSLv3 cipher=RC4-MD5);
        Fri, 26 Mar 2010 15:26:44 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20100326215600.GA10910@spearce.org>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/143290>

Shawn O. Pearce wrote:

> Any ideas?  Why is Git 1.7.0.3 jamming a leading '0' on a file mode?

See http://thread.gmane.org/gmane.comp.version-control.git/141028
and commit c88f0cc (notes: fix malformed tree entry, 2010-02-24).

The regression that that fixes appeared in 61a7cca0 (Notes API:
write_notes_tree(): Store the notes tree in the database, 2010-02-13),
which is not part of 1.7.0.3.

Still, HTH,
Jonathan
