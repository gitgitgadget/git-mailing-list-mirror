From: E R <pc88mxer@gmail.com>
Subject: Re: side-by-side diff for gitweb?
Date: Thu, 25 Jun 2009 20:38:07 -0500
Message-ID: <3a69fa7c0906251838i7d6aa623y87cea3870db6a7fe@mail.gmail.com>
References: <3a69fa7c0906111241w3d105003xecb44125822ac501@mail.gmail.com>
	 <m3zlce35ds.fsf@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jun 26 03:38:22 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MK0OT-0000pc-5b
	for gcvg-git-2@gmane.org; Fri, 26 Jun 2009 03:38:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752373AbZFZBiJ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 25 Jun 2009 21:38:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752234AbZFZBiH
	(ORCPT <rfc822;git-outgoing>); Thu, 25 Jun 2009 21:38:07 -0400
Received: from mail-yx0-f186.google.com ([209.85.210.186]:57955 "EHLO
	mail-yx0-f186.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752126AbZFZBiF convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 25 Jun 2009 21:38:05 -0400
Received: by yxe16 with SMTP id 16so625909yxe.33
        for <git@vger.kernel.org>; Thu, 25 Jun 2009 18:38:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=vMtQYGYa7rp6uI3Fnu66LOQ0Y0s8jt8MabKh1h8thVA=;
        b=hf0jstcYTVvfNZm9yczXL0aohGSMhAwy9/qshc7gWPnYpoOZE4qsFKOb6fC/CKQB46
         V7tsyDGcxxhZKLFaGlYj6rzxmGZGfEC/xTrT26LLVsps93DvBSsSXtbVTBqLcuIdVQei
         h+cNDLUAUFII6qxlS4vY94sEHPTivficBv3/U=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=tA8hj3J70Cvk6xctj0YmZsDyvF/C2MCKKRMXWv3xGFZYUX/clmUi0OtiadiKst4lvw
         Fw7zwl6Fpyben0uSEcknGJQk72Qy3axobsUpknps9GmUZCvI1kajBptWnaKaB0MgicNn
         ZkS0XSg2jLQo7LQQVMDumVB2MAHESwA+yYJcM=
Received: by 10.151.138.11 with SMTP id q11mr5767571ybn.128.1245980287431; 
	Thu, 25 Jun 2009 18:38:07 -0700 (PDT)
In-Reply-To: <m3zlce35ds.fsf@localhost.localdomain>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/122264>

Here's something that could help:

http://svn.tools.ietf.org/tools/rfcdiff/

I don't like their colors, but that should be easy to change.

On Thu, Jun 11, 2009 at 3:03 PM, Jakub Narebski<jnareb@gmail.com> wrote=
:
> E R <pc88mxer@gmail.com> writes:
>
>> Is there a a side-by-side diff viewer for gitweb?
>
> No, it is for a long time on TODO list for gitweb, but it never got
> implemented.
>
>> If not, any suggestions for the best way to go about implementing on=
e?
>
> Take a look at other web interfaces in Perl, and find how they do it
> (IIRC Codestriker web review tool is in Perl, and has side-by-side
> diffs). =A0Ask on #perl. =A0Ask on perlmongers. =A0Search CPAN[1].
>
> [1] Note that we frown upon introducing extra dependencies for gitweb=
,
> unless they are optional, and best detected automatically.
> --
> Jakub Narebski
> Poland
> ShadeHawk on #git
>
