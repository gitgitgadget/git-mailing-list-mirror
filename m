From: Tay Ray Chuan <rctay89@gmail.com>
Subject: Re: Question about git rebase --onto
Date: Wed, 17 Feb 2010 18:19:42 +0800
Message-ID: <be6fef0d1002170219j27c79877k830f8d853719ea2e@mail.gmail.com>
References: <4B6865A9.60603@obry.net> <7v636f7biw.fsf@alter.siamese.dyndns.org>
	 <4B686CAC.7020103@obry.net> <7vhbpx3it2.fsf@alter.siamese.dyndns.org>
	 <4B6AF9EE.3000205@obry.net> <7vr5p1gd2t.fsf@alter.siamese.dyndns.org>
	 <4B7BB604.20205@obry.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Junio C Hamano <gitster@pobox.com>, git list <git@vger.kernel.org>
To: pascal@obry.net
X-From: git-owner@vger.kernel.org Wed Feb 17 11:19:50 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nhh0X-0001hC-EZ
	for gcvg-git-2@lo.gmane.org; Wed, 17 Feb 2010 11:19:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751326Ab0BQKTo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 17 Feb 2010 05:19:44 -0500
Received: from mail-pz0-f187.google.com ([209.85.222.187]:62190 "EHLO
	mail-pz0-f187.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750983Ab0BQKTn (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 17 Feb 2010 05:19:43 -0500
Received: by pzk17 with SMTP id 17so6128746pzk.4
        for <git@vger.kernel.org>; Wed, 17 Feb 2010 02:19:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type;
        bh=AE1DkizAy0T5/i3MwMaYewJ7qiSuEvr40Eqhz3sIJN8=;
        b=R4ZRm3TcO2BydIFOuq4HyjUzqS+UO0AbCP9ZgpiOzrKRoPE2Z2Im7ZMys/78Eac3Io
         c3tmu5sMlVHq3gaZVylMB19xFi8koq5aIFAGcTYP9fe6c+4Tkt8U8Zmwbf5p0Ms4zqh2
         +xUhiBiJHIV2IptTod5TV/9xQ+nkGmPv8U2DA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=qO15nilucWRiDgSIo/26a9MslaulWb2p1r74RLD2pZWrfNazl6F2qxS/jwTofOO1Lj
         tKhQKrrsQes1G09EuaOWppQKVFZKAq7k6JKxkZBcJU/2i6UYCyOrMQj2XSfaDDrc78ZO
         6BrZuuQc6pqXMR6wsy491XchccczlqOM0k6ds=
Received: by 10.142.152.8 with SMTP id z8mr5153023wfd.230.1266401982442; Wed, 
	17 Feb 2010 02:19:42 -0800 (PST)
In-Reply-To: <4B7BB604.20205@obry.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/140226>

Hi,

On Wed, Feb 17, 2010 at 5:25 PM, Pascal Obry <pascal@obry.net> wrote:
> $ git clone http://git.sv.gnu.org/r/v2p.git

in case anyone is wondering, the equivalent git:// url is

  git://git.sv.gnu.org/v2p.git

> $ git rebase --onto v3.1 HEAD~3 HEAD

Why do you add the last parameter ("HEAD")? If I run the rebase
without it, it works fine (ie. not on a detached HEAD).

-- 
Cheers,
Ray Chuan
