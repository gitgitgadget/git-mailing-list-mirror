From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH v2] completion: add new git_complete helper
Date: Mon, 16 Apr 2012 23:30:59 +0300
Message-ID: <CAMP44s0CVsmHw4jQqHvZMi342V8-Yh2zYYcAE_5EHu5OAiktcw@mail.gmail.com>
References: <1334524814-13581-1-git-send-email-felipe.contreras@gmail.com>
	<20120415213718.GB5813@burratino>
	<CAMP44s0PWAV=nD1xnAFMx8OPby88W2jKwDGtiUFY4LA93D-gAw@mail.gmail.com>
	<7vaa2by8nj.fsf@alter.siamese.dyndns.org>
	<20120416160729.GM5813@burratino>
	<CAMP44s2_VYNFeBi9GPa9CeqT=oRmSq1J1XaSP+aKgC6bJ55Lfg@mail.gmail.com>
	<20120416200941.GD12613@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	=?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder@ira.uka.de>,
	Thomas Rast <trast@student.ethz.ch>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Mon Apr 16 22:31:13 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SJsZp-0002bt-Ng
	for gcvg-git-2@plane.gmane.org; Mon, 16 Apr 2012 22:31:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755615Ab2DPUbD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 16 Apr 2012 16:31:03 -0400
Received: from mail-ee0-f46.google.com ([74.125.83.46]:49410 "EHLO
	mail-ee0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755607Ab2DPUbA (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 Apr 2012 16:31:00 -0400
Received: by eekc41 with SMTP id c41so1418368eek.19
        for <git@vger.kernel.org>; Mon, 16 Apr 2012 13:30:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=5dGs6Nxv2hEnLyBJEfn6QH+bR4TysTvloHFEZg5K/fQ=;
        b=Doy+AOLuTHxGAasmu20RSfktDacpLjw+iMLiU+cqoKQXUg/tYRH0nQPZjatYCIY04J
         up6Vd1tPMgOeM0Uj0JDu18yTF1XyKX4KRMapvf4ksHT13YdDG/7RL3Ql2IVcX0a6mcIw
         yV+NHGc4meHdd994dSjssIt+D5+uwB17jw6Px9YcltSh6ptvLrN/SoE2VURwqsu4F8kB
         1RsEJafRUfMeJLolT5V3zc9sDYAwe3ZwQDrsZzs+41qMO56gTgIth9511EHoL6N3H4qy
         gHv0ZleBpbNwoUsg6kj4PrQxwQKsWnI2WkricIqr2qESeUkBSEXaD6s7NlMYE7seExnc
         u7cw==
Received: by 10.14.182.194 with SMTP id o42mr1865678eem.50.1334608259310; Mon,
 16 Apr 2012 13:30:59 -0700 (PDT)
Received: by 10.213.19.67 with HTTP; Mon, 16 Apr 2012 13:30:59 -0700 (PDT)
In-Reply-To: <20120416200941.GD12613@burratino>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/195688>

On Mon, Apr 16, 2012 at 11:09 PM, Jonathan Nieder <jrnieder@gmail.com> wrote:
> Felipe Contreras wrote:
>
>> I would like to see a completion script that actually has a function
>> supposed to be exported and that still uses the _ prefix anyway.
>
> The /etc/bash_completion library itself exports lots and lots of
> functions with a _ prefix.

We are not making a bash_completion library; I mean a bash completion
script (other than the library).

-- 
Felipe Contreras
