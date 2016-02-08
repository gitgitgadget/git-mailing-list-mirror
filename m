From: Leonardo <leobasilio@gmail.com>
Subject: Re: Merging branches with smudge filter
Date: Mon, 8 Feb 2016 15:52:36 -0200
Message-ID: <CACqLfM=G-=kD+wnDG-oWz4-eKW1ET_vnsenEXdCDwRsv0YXcSA@mail.gmail.com>
References: <CACqLfMk_qDhbXUjWLtBLP4o=CeKEgaWAm881h03fneuiRO-v2w@mail.gmail.com>
 <xmqqbn7r9kfz.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Feb 08 18:53:01 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aSpzg-0000wJ-Vi
	for gcvg-git-2@plane.gmane.org; Mon, 08 Feb 2016 18:53:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754401AbcBHRw5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 8 Feb 2016 12:52:57 -0500
Received: from mail-io0-f169.google.com ([209.85.223.169]:35259 "EHLO
	mail-io0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753024AbcBHRw4 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 8 Feb 2016 12:52:56 -0500
Received: by mail-io0-f169.google.com with SMTP id d63so203343148ioj.2
        for <git@vger.kernel.org>; Mon, 08 Feb 2016 09:52:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=kWVuhFTOx5ZnY03oJ1oPT7dKp2N0IXY7AeUQC3agnlk=;
        b=sNEFLcIrci7lRys4dOBnIX/YwLgTQzmfg6hLowahxUN8+MNd+ynTrukSEFY7vip6AZ
         3CxKiMxLswQRuM2llGGQbHddoS5m6QIUFiliBQOosuLNw+sxkYBGCAqIP9k95K+T/ENf
         f8y515vbe9lvulqVsEhVJ7lPCX8HYZj0DkM3cxF2wdmKo3fxGKrAilTsTWjIsFIm+2aQ
         mRGrznUgrGSFAdrD155si0xJopNYZdkb0zK7VfcEW4h4oGLo+N1CUdszpaNGKs0hXuFW
         Cj/kgcfsNC3LsPvQQHBNziN67wry7GGOhX1TwcKJDckFdlT7CmOmcH+y9C7JnXPLnlYV
         OroQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-type;
        bh=kWVuhFTOx5ZnY03oJ1oPT7dKp2N0IXY7AeUQC3agnlk=;
        b=Ecw3WDIt0dVMLHxETiNj8b9XwZcyZMaP0r6ijMx9k1KN5/cyEjy1t/WiLFbsI4CaYo
         iPaAeVQIwztsKubosPeWJYXY6eVAkYrDqeKyaEdhSr8ZgNuZVyZDhSElH5vPyPLny/7z
         OmDmcfzBOK2qhWgFQwQsBq537CUquDIkJGNBod9t4+4qfi/0uc3O7iCqiyz7pYKL4z7e
         ye5YwVXyR9BGDXypgq26A6XRj6n4pePoTJML7RIQdy8FHW7l88QkDUVmmHrz9nFNuo72
         cyl9vgIeex/SRlqiEdWIniqVOLBWNJXUom08dYSR4mRi1V2Jxc1lMbdGodrqlFT+6pZj
         QklA==
X-Gm-Message-State: AG10YORJ/6FdA+P0OlbSwHdoVeVtqInee5xcP3opMtLnuXPg7H54eqGturHKZ4C2EeZMLTAyE9ifYLp3NBjAeA==
X-Received: by 10.107.157.70 with SMTP id g67mr26635582ioe.38.1454953975879;
 Mon, 08 Feb 2016 09:52:55 -0800 (PST)
Received: by 10.107.162.149 with HTTP; Mon, 8 Feb 2016 09:52:36 -0800 (PST)
In-Reply-To: <xmqqbn7r9kfz.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/285784>

Hi. I understand what you mean, but if that's the case, I don't get
how every file was merged successfully despite the encryption, except
two of them. I thought the smudge filter was supposed to be applied to
every blob before any git operation, thus exposing the clean source
code. Well, in the end I've merged these two files manually. I think I
might have done something wrong while branching. I'm still learning.
Next time I'll be more attentive.

2016-02-08 15:32 GMT-02:00 Junio C Hamano <gitster@pobox.com>:
> Leonardo <leobasilio@gmail.com> writes:
>
>> Hi, everybody. I'm new to git and I'd like to keep track of some codes
>> we have here in our company. They have some sensitive information I
>> would like to keep private. After some googling, I found some
>> solutions that encrypt/decrypt the files using filters as they're
>> committed/checked out. I've been using this approach and it suits my
>> needs. Now I need to merge two branches, but the process is failing
>> for two files in particular. First of all, here's my config file:
>>
>> [filter "openssl"]
>>     clean = openssl enc -aes-256-cbc -a -nosalt -pass pass:password
>>     smudge = openssl enc -d -aes-256-cbc -a -nosalt -pass pass:password
>>     required
>
> Git works on the "clean" representation of the data, i.e. the
> representation of the blob object stored in the object database and
> in the index, when manipulating the contents, e.g. diffing two
> variants, patching (think "add -p"), merging, etc.
>
> As you are making the "clean" version an encrypted opaque sequence
> of bytes, it is expected that you wouldn't be able to run 3-way
> merges.
