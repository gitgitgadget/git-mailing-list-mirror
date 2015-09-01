From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3] git-p4: add "--path-encoding" option
Date: Tue, 01 Sep 2015 10:35:04 -0700
Message-ID: <xmqqmvx6rqk7.fsf@gitster.mtv.corp.google.com>
References: <1441059026-66814-1-git-send-email-larsxschneider@gmail.com>
	<1441059026-66814-2-git-send-email-larsxschneider@gmail.com>
	<xmqqk2sbt5kv.fsf@gitster.mtv.corp.google.com>
	<523D2C52-893E-4A54-9DD1-2DDBCEA29960@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, luke@diamand.org, tboegi@web.de
To: Lars Schneider <larsxschneider@gmail.com>
X-From: git-owner@vger.kernel.org Tue Sep 01 19:35:14 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZWpSk-0006Lt-9M
	for gcvg-git-2@plane.gmane.org; Tue, 01 Sep 2015 19:35:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752611AbbIARfH convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 1 Sep 2015 13:35:07 -0400
Received: from mail-pa0-f53.google.com ([209.85.220.53]:36765 "EHLO
	mail-pa0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751343AbbIARfG (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 1 Sep 2015 13:35:06 -0400
Received: by pacwi10 with SMTP id wi10so2360601pac.3
        for <git@vger.kernel.org>; Tue, 01 Sep 2015 10:35:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type:content-transfer-encoding;
        bh=xXMFMahPUFpc8DLnSrv4QjY4vnvS+qP2h4mdIraEPP0=;
        b=h05GxlWxaf0D+oUJ5x1tR0vxVndxjUuBBNAgAzPYGy3Y8vyElkGcZXVMlhyFdjS50F
         5jVcAHa21CR5O5rTBcFKMc96gaB5VFJ9ABsj5NVqW8SBHwvrzGN7S2Qd49g3/w2k6omz
         jUfLx9O8IMpLe6hM8gkhCCsnH/V/RpPIl4nB6GNHJnEEqf5be9StNBvGMPVQ85X3SzxP
         Nz6/2IuCztpFUzw1Es+qostVqqS9xcqyGCl2DuTIubf9O2gyewt+pM3G/jHCKfdOXjN4
         tRfmV1IQkFfLw8eZ9RCjQo9vkhM2TTOxgQS7rBc85avJ628V10IXCJkZGix+KjFCS+Dh
         WpHg==
X-Received: by 10.66.219.39 with SMTP id pl7mr48371522pac.148.1441128906154;
        Tue, 01 Sep 2015 10:35:06 -0700 (PDT)
Received: from localhost ([2620:0:1000:861b:c585:9fe7:e0d8:e718])
        by smtp.gmail.com with ESMTPSA id si1sm18795143pbc.72.2015.09.01.10.35.05
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Tue, 01 Sep 2015 10:35:05 -0700 (PDT)
In-Reply-To: <523D2C52-893E-4A54-9DD1-2DDBCEA29960@gmail.com> (Lars
	Schneider's message of "Tue, 1 Sep 2015 15:42:39 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/276998>

Lars Schneider <larsxschneider@gmail.com> writes:

> On 01 Sep 2015, at 01:13, Junio C Hamano <gitster@pobox.com> wrote:
>
>> larsxschneider@gmail.com writes:
>>=20
>>> From: Lars Schneider <larsxschneider@gmail.com>
>>>=20
>>=20
>> Here is a space for you to describe what it does and why it is a
>> good idea to have it.
> How about this:
>
> Perforce keeps the encoding of a path as given by the originating
> OS. Git expects paths encoded as UTF-8. Add an option to tell git-p4
> what encoding Perforce had used for the paths. This encoding is used
> to transcode the paths to UTF-8. As an example, Perforce on Windows
> uses =E2=80=9Ccp1252=E2=80=9D to encode path names.

Very readable.  Does "Perforce on Windows" always use cp1252, or
is it more correct to say "often uses" here?
