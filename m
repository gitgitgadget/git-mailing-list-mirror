From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH] t3000 (ls-files -o): modernize style
Date: Sun, 11 Jul 2010 10:14:32 -0500
Message-ID: <20100711151432.GA1781@burratino>
References: <20100711042025.GA7424@burratino>
 <m3d3uul8pd.fsf@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Sun Jul 11 17:15:25 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OXyFY-0001C5-Rv
	for gcvg-git-2@lo.gmane.org; Sun, 11 Jul 2010 17:15:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754604Ab0GKPPS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 11 Jul 2010 11:15:18 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:33305 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754535Ab0GKPPR (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 11 Jul 2010 11:15:17 -0400
Received: by iwn7 with SMTP id 7so3814048iwn.19
        for <git@vger.kernel.org>; Sun, 11 Jul 2010 08:15:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=JP7uVpp0msv1enVtCz/EKl8Ny7Q2xNSVCyt44ODaRgw=;
        b=mgq/6UtgTjgMhiUfWNpz/8L06qil70PWtTmtSr8mcXD64HC6Yfugbs2iN+6xOcb3Dw
         Hmf0z0v2qPViBwE08eVflSdfxVq/5AGHKVpE5HforIMMJsApQ+Aentws+hPydjXIWHpu
         xx38j0a+T4zO6zse4bxYjVx66AKV4xZaaKmcg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=kWmsflSepqQ6L/DZXHnKAevJlR9n8e21yyyBJfbyQR90R5MPni7e7Ev2RWzhWCknsh
         7uoH8KmMs0zg7l491ohM/2yt7nEet9By4Z36LoYRmAbNJhGHyuEfPyv8UTlLJWSK44GZ
         ISyCAoD9fg70FYpL3XZS5HkXhXdo6mpp4R/ys=
Received: by 10.231.174.72 with SMTP id s8mr10123085ibz.41.1278861316487;
        Sun, 11 Jul 2010 08:15:16 -0700 (PDT)
Received: from burratino (c-98-212-3-231.hsd1.il.comcast.net [98.212.3.231])
        by mx.google.com with ESMTPS id 34sm14820975ibi.6.2010.07.11.08.15.15
        (version=SSLv3 cipher=RC4-MD5);
        Sun, 11 Jul 2010 08:15:16 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <m3d3uul8pd.fsf@localhost.localdomain>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/150780>

Jakub Narebski wrote:

> ... I don't think it is really needed.  There isn't anything there
> that can fail, and there isn't anything there that produces any
> output.

I should clarify.  I wrote this patch as preparation to add some new
tests to the same script.  The new tests are not cooked yet, so I just
sent the trivial part; there certainly is no urgent reason to apply it
soon (though no reason I see not to apply it either).

A better explanation for the rationale would be "follow the modern
style to make the script more readable and set a good example for
future tests".

> BTW. do all sane shells that can be used to run test suite support
> '<<-' here-doc redirection operators?  Is it in POSIX?

Yes[1] and yes[2].

Thanks for looking it over.
Jonathan

[1] $ git grep -l -F -e '<<-EO' -e '<<-\EO' origin/maint -- t | wc -l
    13
[2] http://www.opengroup.org/onlinepubs/9699919799/utilities/V3_chap02.html#tag_18_07_04
