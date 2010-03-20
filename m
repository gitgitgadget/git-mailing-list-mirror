From: Alex Riesen <raa.lkml@gmail.com>
Subject: Re: GSoC draft proposal: Line-level history browser
Date: Sat, 20 Mar 2010 21:35:54 +0100
Message-ID: <81b0412b1003201335g7b37c51mfa3e2280210ebb7e@mail.gmail.com>
References: <41f08ee11003200218u59c45b6dl82a8eb56cc289256@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org
To: Bo Yang <struggleyb.nku@gmail.com>
X-From: git-owner@vger.kernel.org Sat Mar 20 21:36:03 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nt5Or-00010n-UO
	for gcvg-git-2@lo.gmane.org; Sat, 20 Mar 2010 21:36:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752390Ab0CTUf5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 20 Mar 2010 16:35:57 -0400
Received: from mail-bw0-f209.google.com ([209.85.218.209]:38702 "EHLO
	mail-bw0-f209.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751339Ab0CTUf5 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 20 Mar 2010 16:35:57 -0400
Received: by bwz1 with SMTP id 1so885452bwz.21
        for <git@vger.kernel.org>; Sat, 20 Mar 2010 13:35:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type;
        bh=6mc+jl+nt7twk8WAcLyAzW4lXTKwt+FxGBMVEa1xuuA=;
        b=EXxhyccdWMIPxNL8Uc15RXFLCA02FR1T9ovn5+3HXNTwaJvcXiDWcf80lfeOdSIUwD
         YWtCeeEis5884v+gjEzAg5whaBejtbEg5wgxmyOWSb+5q8hnS0dIC/pqbvHMiacLb0Sd
         RQXHK/1vRVB9tjIzKVDrNISxhvtH7TOg5y70c=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=PEhWBBy9ywrxjs0G/PQi3+aUjD1CpFhu9NCrfZLNsFF/6m5/i3aX1dLNkFYntpj0rd
         2Fwy7PyfkS+VUH8xLre3XmIYZA2gBrxcAVzSivgVJxkYSAY+mVxqr/T2BQbzHxIDX3Sy
         TuL35c2OYEaCEHWjmeBbIQJnvZXVEZeO2Z6tE=
Received: by 10.204.14.84 with SMTP id f20mr1659501bka.209.1269117354539; Sat, 
	20 Mar 2010 13:35:54 -0700 (PDT)
In-Reply-To: <41f08ee11003200218u59c45b6dl82a8eb56cc289256@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/142747>

On Sat, Mar 20, 2010 at 10:18, Bo Yang <struggleyb.nku@gmail.com> wrote:
> <line range>
> Its format should be <start pos>..<end pos> or just a <line number>.

You might want to reconsider the line range syntax. Exactly the same syntax
is already used to specify a commit range, so reusing it may lead to confusion.
