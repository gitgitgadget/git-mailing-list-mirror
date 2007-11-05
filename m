From: "David Symonds" <dsymonds@gmail.com>
Subject: Re: [PATCH] Rearrange git-format-patch synopsis to improve clarity.
Date: Tue, 6 Nov 2007 09:32:25 +1100
Message-ID: <ee77f5c20711051432w284cf22dx71192c145d25dced@mail.gmail.com>
References: <119421522591-git-send-email-dsymonds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, "David Symonds" <dsymonds@gmail.com>
To: "Junio C Hamano" <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Nov 05 23:32:43 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IpAUr-0007pj-RR
	for gcvg-git-2@gmane.org; Mon, 05 Nov 2007 23:32:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752082AbXKEWc0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 5 Nov 2007 17:32:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752045AbXKEWc0
	(ORCPT <rfc822;git-outgoing>); Mon, 5 Nov 2007 17:32:26 -0500
Received: from rv-out-0910.google.com ([209.85.198.186]:15522 "EHLO
	rv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751887AbXKEWc0 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 5 Nov 2007 17:32:26 -0500
Received: by rv-out-0910.google.com with SMTP id k20so1654057rvb
        for <git@vger.kernel.org>; Mon, 05 Nov 2007 14:32:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=m0sIR/dC+sefqNBFrSyDXGefXjHbnynm/qTKdqKrrQM=;
        b=snjB62S/akt0seZOiT0Fzu9wLUCj1/2tJWXL5h76E7W62UcXgZl/MDEXLxdkl82rOHpdSQ2C1Tfxe0IPaN108NV//P4TBGlsBmEf8ckxKNEr264TYmVlNoWelpXWEkr+bUuAuDijiJLJT6orDF4QT7PPE0weLfhCA1VvevZDAt8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=LbH2GiTGCGLQNMfKPexVb5lA1NmJxIlkY6BMFikgQt3khKEi0x+W+Z6K77gqZxzJvHIErSjCTM6JugiH5XhcWiCcJe/ffy+CaVuiDkN/EH1qnaR95qtlr76Nad0XJqo2EJbTmXVLAvOlH2kjWSRTAbhwUiJ9KPRFPXubo3JjgP0=
Received: by 10.141.151.15 with SMTP id d15mr2676160rvo.1194301945222;
        Mon, 05 Nov 2007 14:32:25 -0800 (PST)
Received: by 10.141.115.4 with HTTP; Mon, 5 Nov 2007 14:32:25 -0800 (PST)
In-Reply-To: <119421522591-git-send-email-dsymonds@gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/63575>

On 11/5/07, David Symonds <dsymonds@gmail.com> wrote:
>                     [-s | --signoff] [<common diff options>]
> -                   [--start-number <n>] [--numbered-files]
> +                   [-n | --numbered-files | -N | --no-numbered]
> +                   [--start-number <n>]

Now that I look at it again, it seems the long options look quite
inconsistent. I think it should be either
--numbered-files/--no-numbered-files or --numbered/--no-numbered. My
preference is with the latter (for brevity), but that breaks
backward-compatibility.

Would you accept a patch that changed --numbered-files to --numbered,
and kept the former as a synonym?


Dave.
