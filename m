From: Simon <turner25@gmail.com>
Subject: Re: More git status --porcelain lossage
Date: Sat, 10 Apr 2010 14:48:05 -0400
Message-ID: <l2k5f14cf5e1004101148h5cf8dc4bm1836cf1c5fc8abfb@mail.gmail.com>
References: <20100409190601.47B37475FEF@snark.thyrsus.com>
Reply-To: turner25@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Eric Raymond <esr@snark.thyrsus.com>
X-From: git-owner@vger.kernel.org Sat Apr 10 20:48:17 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O0fj5-0007Hy-VV
	for gcvg-git-2@lo.gmane.org; Sat, 10 Apr 2010 20:48:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751926Ab0DJSsK convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 10 Apr 2010 14:48:10 -0400
Received: from mail-gw0-f46.google.com ([74.125.83.46]:35986 "EHLO
	mail-gw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751050Ab0DJSsI convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 10 Apr 2010 14:48:08 -0400
Received: by gwj19 with SMTP id 19so323108gwj.19
        for <git@vger.kernel.org>; Sat, 10 Apr 2010 11:48:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:reply-to:in-reply-to
         :references:date:received:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=O2TMe9tpzNKNBPBRHnhByyjUzqUba3eXpLX2svxINqA=;
        b=x7H/44UxXBVJ3mDbBY2At7S25cBVYvnX2Af/vjzpTfSxcu5v65o7WN+D/jKnOL2q3I
         YH+Y1i4kzVCtAw1YuWWby2mFngy+XJ72FW6E1nFj0Unp/unemHg+0yG3oxxlFjZImF1d
         0vcQMlnar0fw0csyP+w6P0YNraLOfU41PMWGY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:reply-to:in-reply-to:references:date:message-id
         :subject:from:to:cc:content-type:content-transfer-encoding;
        b=B7srwfKaotxctYgUpQanrkkn0u99Vq4SkezGQJeCF0J+Y522uO8U4eNXXcaN0bMkuV
         XknldPTj+632FU61c22MoprLm2wfmh5j9qp6LiNhFnNM8/psAbFXw3eFhe81P7MQvn3h
         AOohyHogbtWsCQwC3nZX1XEanrYRYu+JaYcP4=
Received: by 10.100.142.16 with HTTP; Sat, 10 Apr 2010 11:48:05 -0700 (PDT)
In-Reply-To: <20100409190601.47B37475FEF@snark.thyrsus.com>
Received: by 10.101.135.40 with SMTP id m40mr3334785ann.1.1270925285636; Sat, 
	10 Apr 2010 11:48:05 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/144576>

> A format properly designed for script parseability should use even us=
e
> whitespace as a field separator.
>
> Why?
>
> Because if you do that, front ends *will* do field analysis using a
> naive split-on-whitespace operation. =A0And then...someday...someone
> will try to run one of these of these on a volume from a system where
> filenames contain embedded whitespace. =A0Like Mac OS X or Windows.

Why not use an XML output?
Plain text is easier to parse, but XML may give this extra durability
you are looking for?

Simon
