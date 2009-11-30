From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: git include
Date: Mon, 30 Nov 2009 14:29:46 +0700
Message-ID: <fcaeb9bf0911292329p672572dcmbe0c01912d50fd0a@mail.gmail.com>
References: <4B136932.9000908@gulfsat.mg> <fcaeb9bf0911292245t6b18c238s2859d2cbd5dd26be@mail.gmail.com> 
	<20091130104055.3c3274f5@Office>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org
To: Armen Baghumian <armen@opensourceclub.org>
X-From: git-owner@vger.kernel.org Mon Nov 30 08:30:13 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NF0i5-0001bf-54
	for gcvg-git-2@lo.gmane.org; Mon, 30 Nov 2009 08:30:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753836AbZK3HaA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 30 Nov 2009 02:30:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753815AbZK3HaA
	(ORCPT <rfc822;git-outgoing>); Mon, 30 Nov 2009 02:30:00 -0500
Received: from mail-pz0-f171.google.com ([209.85.222.171]:37267 "EHLO
	mail-pz0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753482AbZK3H37 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 30 Nov 2009 02:29:59 -0500
Received: by pzk1 with SMTP id 1so2321893pzk.33
        for <git@vger.kernel.org>; Sun, 29 Nov 2009 23:30:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :from:date:message-id:subject:to:cc:content-type;
        bh=AHyOaQxbI5OdakfNZT/et76R4K9GidArgSdnHYI4nFQ=;
        b=I2hH9uMSd4lhHLEdF4q4l4xgnkFNhbI8aA719ovaC90p3LxNbhxaB5cVDYVuEURHCl
         vb+D2ZL5mULhUtt6AgqQAIjchtwfK/7M/mJPQ19N5qUADWTqgAjPrWlCmcAdEnxvXKLg
         uhxSTAEFSBA+0YvUt9kOStDocjrV/3DboSSWg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        b=unoeKFYiTlM0/uQIeHfRzC9KtWu4MWp7FCqPKJMwlEZ2uLj9iYewnkdoal10a7azN8
         g7BiO2kV2X8POfkohh7Zf01075OjtGHetHaCuVm+YjmsLUV4v96corTEPX7GaOUrcyHL
         egmQu4gc34qv6YWn1DKEVuIPnXDblYwQ66W9M=
Received: by 10.115.98.29 with SMTP id a29mr6654797wam.142.1259566206056; Sun, 
	29 Nov 2009 23:30:06 -0800 (PST)
In-Reply-To: <20091130104055.3c3274f5@Office>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/134066>

On Mon, Nov 30, 2009 at 2:10 PM, Armen Baghumian
<armen@opensourceclub.org> wrote:
>
> Probably you want to add .gitignore too
>
> *
> !*.ml
> !.gitignore

In that case it should be "!.git*" as you may miss .gitattributes or .gitmodules
-- 
Duy
