From: Michael Witten <mfwitten@gmail.com>
Subject: Re: [PATCH RFC3.5 05/12] send-email: Improve redability and 
	error-handling in send_message's sendmail code
Date: Sat, 18 Apr 2009 21:13:20 -0500
Message-ID: <b4087cc50904181913g117937le333c3b255f7d184@mail.gmail.com>
References: <1240074128-16132-1-git-send-email-mfwitten@gmail.com>
	 <1240074128-16132-2-git-send-email-mfwitten@gmail.com>
	 <1240074128-16132-3-git-send-email-mfwitten@gmail.com>
	 <1240074128-16132-4-git-send-email-mfwitten@gmail.com>
	 <1240074128-16132-5-git-send-email-mfwitten@gmail.com>
	 <1240074128-16132-6-git-send-email-mfwitten@gmail.com>
	 <76718490904181851g2701ce59x614ea60452b914ce@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org
To: Jay Soffian <jaysoffian@gmail.com>
X-From: git-owner@vger.kernel.org Sun Apr 19 04:14:59 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LvMYa-00084W-Ao
	for gcvg-git-2@gmane.org; Sun, 19 Apr 2009 04:14:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753941AbZDSCNX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 18 Apr 2009 22:13:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753667AbZDSCNW
	(ORCPT <rfc822;git-outgoing>); Sat, 18 Apr 2009 22:13:22 -0400
Received: from qw-out-2122.google.com ([74.125.92.26]:52034 "EHLO
	qw-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753458AbZDSCNV convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 18 Apr 2009 22:13:21 -0400
Received: by qw-out-2122.google.com with SMTP id 5so565104qwd.37
        for <git@vger.kernel.org>; Sat, 18 Apr 2009 19:13:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=QR9cHH1fgDIw72d/npbBJq/mmZdYpDG5V/ZB5PR8J9w=;
        b=xqkqCGK33OQY8uSx9FZ74Vx63xnFHYMxZkAObi8ItqNIQeYdHXPZAQqhDZBq9EVMuk
         WnakGo2+9Apo5OKIAx5oGQWzetGY9kub4CGGkvms0HGXFsIVuRFHJlIyRQHrtiW+LT+8
         dZeMMyyph9ChofW/240wzH0M95rzMeBYfrW8A=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=aHuUU5vTaIDYsbx8KASDAH0iyOzqG/jDWWT927I7Eiy2ZsadngjcNdWwFQfgI68QSb
         zdALR2/ZVnmTlRaFBO3K4hPwixUQJSfd9fpkwzip0wrgfBCV6XwyZK4kS0hs18/JfHAm
         L7/GsHA9pex3x3sfu1cy5bMaI1MfXCQait6oI=
Received: by 10.224.2.202 with SMTP id 10mr5161990qak.336.1240107200286; Sat, 
	18 Apr 2009 19:13:20 -0700 (PDT)
In-Reply-To: <76718490904181851g2701ce59x614ea60452b914ce@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/116876>

On Sat, Apr 18, 2009 at 20:51, Jay Soffian <jaysoffian@gmail.com> wrote:
> What is '//' about?

It's called the Logical Defined-OR:

    http://perldoc.perl.org/perlop.html#C-style-Logical-Defined-Or

> Although it has no direct equivalent in C, Perl's // operator is related to its C-style or. In fact, it's exactly the same as ||, except that it tests the left hand side's definedness instead of its truth. Thus, $a // $b is similar to defined($a) || $b  (except that it returns the value of $a rather than the value of defined($a)) and is exactly equivalent to defined($a) ? $a : $b . This is very useful for providing default values for variables. If you actually want to test if at least one of $a  and $b  is defined, use defined($a // $b) ...

However, I wonder if your comment is a veiled quip at my "Improve
redability" claim (which is also ironically unreadable). :-)
