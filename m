From: "Lars Hjemli" <hjemli@gmail.com>
Subject: Re: Git submodule enhancements
Date: Wed, 24 Sep 2008 11:25:21 +0200
Message-ID: <8c5c35580809240225ld59fe28g10ecd09d1962ef3c@mail.gmail.com>
References: <200809241100.30758.p_christ@hol.gr>
	 <8c5c35580809240213v5198d2abh489915dc1133c75@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: "Git Mailing List" <git@vger.kernel.org>
To: "P. Christeas" <p_christ@hol.gr>
X-From: git-owner@vger.kernel.org Wed Sep 24 11:26:34 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KiQdk-0000hZ-Tx
	for gcvg-git-2@gmane.org; Wed, 24 Sep 2008 11:26:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751647AbYIXJZY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 24 Sep 2008 05:25:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751514AbYIXJZY
	(ORCPT <rfc822;git-outgoing>); Wed, 24 Sep 2008 05:25:24 -0400
Received: from wa-out-1112.google.com ([209.85.146.180]:45436 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751532AbYIXJZX (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 24 Sep 2008 05:25:23 -0400
Received: by wa-out-1112.google.com with SMTP id j37so1847517waf.23
        for <git@vger.kernel.org>; Wed, 24 Sep 2008 02:25:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=xb+CcrRBgnKcnOqRkXqVuArSvTNbJ+Yrjwf43fJLQak=;
        b=lQq538XDacdQ+pK4PxKT0p6lTJas314BEifEqetTCzW3s5GI2nR0EEzH6PC4vhDqGf
         tErc1XB6GY481PZx3WBRXds5Qf11yl3g8OVoTjZgV/6YRIFitEBPPAgewFgzU90Qf6PT
         prOqc3WQo09MDgPfzktxvXe8L6Dg1XXqljku4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=IWFaHffj04zzOsDHNExCpYOgLsdF7hxCJYmtedtIGul6q4G8ywUZNP6KFuBn2ufOmz
         bvn3b7B+kj5wqHRg8NQ8/kenWkIlw/zP61SHodx/3+5o0OH0LZY+OKclX4ptdwZKHLZf
         kAjVVIAutdk0WKLdhd1ja5vI9MpPD/hK5sNW8=
Received: by 10.115.49.11 with SMTP id b11mr7757260wak.117.1222248321289;
        Wed, 24 Sep 2008 02:25:21 -0700 (PDT)
Received: by 10.114.166.20 with HTTP; Wed, 24 Sep 2008 02:25:21 -0700 (PDT)
In-Reply-To: <8c5c35580809240213v5198d2abh489915dc1133c75@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/96623>

On Wed, Sep 24, 2008 at 11:13 AM, Lars Hjemli <hjemli@gmail.com> wrote:
> On Wed, Sep 24, 2008 at 10:00 AM, P. Christeas <p_christ@hol.gr> wrote:
> +                       # Cloned mode: we try to figure out the submodule
> +                       # path in the remote origin.
> +                       # FIXME: we do use "../" because the remote is the .git/
> +                       url=$(resolve_relative_url "../$path/.git")
> +               fi
> +
>                git config submodule."$name".url "$url" ||
>                die "Failed to register url for submodule path '$path'"
> --
> 1.6.0.1
>
>
> It looks like --cloned requires the downstream to know which
> submodules are available from the same remote as the supermodule (and
> with the same path as registered in the supermodule)

Hmm, after reading through this once more I guess you're trying to
clone a non-bare repository, possibly also lacking a .gitmodules file
(hence the --force)?

--
larsh
