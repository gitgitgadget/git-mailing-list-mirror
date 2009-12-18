From: Eugene Sajine <euguess@gmail.com>
Subject: Re: repo corruption - Egit's fault?
Date: Fri, 18 Dec 2009 13:51:11 -0500
Message-ID: <76c5b8580912181051j7e2ceb34p98127b316a0118ee@mail.gmail.com>
References: <76c5b8580912181006p2aef9d2fj95bb4c8456d965b@mail.gmail.com>
	 <20091218181613.GA10687@spearce.org>
	 <76c5b8580912181030k56cb7dd7l811c0a0d4773d309@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Fri Dec 18 19:51:22 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NLhv7-0007Ot-DZ
	for gcvg-git-2@lo.gmane.org; Fri, 18 Dec 2009 19:51:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932378AbZLRSvQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 18 Dec 2009 13:51:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755390AbZLRSvQ
	(ORCPT <rfc822;git-outgoing>); Fri, 18 Dec 2009 13:51:16 -0500
Received: from mail-iw0-f171.google.com ([209.85.223.171]:47698 "EHLO
	mail-iw0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755365AbZLRSvM (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 18 Dec 2009 13:51:12 -0500
Received: by iwn1 with SMTP id 1so2360067iwn.33
        for <git@vger.kernel.org>; Fri, 18 Dec 2009 10:51:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type;
        bh=uy+1u4UIEeFldbCXFs7B2FjNnVae5Of/YHs9jz1JS1Q=;
        b=wmdJDZZV8EJG8B44iYjSejRJ1VprjxMMiO2XGRljp4hU7Fg9krE1NWbCIRbgtrQk/Q
         NtQRyu9Z/YmY3zvLJLTXB3gm4z+7AHuFoEgWqf8d1FjwvgNXQyRX9Yf0hR/lcP6mjR5T
         4Tc01VGLTZNhZ2TcsikxX1D5H+8ozOQKHBIY4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=ES9ubKmMCsejwW/tVCd4azLkN7OXKn0q/+v1oUxPyFhdJvSN7crAvf22YDQHx0sBBo
         EqN8Yq1zE3rc8OP1NzUcO9T0w93YmOkeDXtUE9LO0dCC3n6Lv1klSKcuv8NwTOLAab61
         0vtu3HjncjJeNcmGYMScwW/73c1auoIBRkxbw=
Received: by 10.231.5.90 with SMTP id 26mr867213ibu.42.1261162271861; Fri, 18 
	Dec 2009 10:51:11 -0800 (PST)
In-Reply-To: <76c5b8580912181030k56cb7dd7l811c0a0d4773d309@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/135427>

> Thank you for prompt answer, Shawn!
>
> The problem is that as i'm maintaining multiple repos and their
> quantity will grow i would need to apply this setting site wide. Do
> you know if i can specify this service for git daemon? It seems like
> in git deamon docs this service is not listed, but just in case the
> docs are not up to date... I really don't want to set this up for
> every repo manually...
>
> Thanks,
> Eugene
>

I found it.
$ git config --global receive.fsckObjects true

should do the trick.

Thanks,
Eugene
