From: Brandon Casey <drafnel@gmail.com>
Subject: Re: [PATCH v2 02/10] t/test-lib-functions.sh: allow to specify the
 tag name to test_commit
Date: Tue, 22 Jan 2013 01:43:05 -0800
Message-ID: <CA+sFfMeZ0VoySUtpYFZcjSxGQithhKUHarOr3TuioyjaYddsXg@mail.gmail.com>
References: <1358757627-16682-1-git-send-email-drafnel@gmail.com>
	<1358757627-16682-3-git-send-email-drafnel@gmail.com>
	<20130122080216.GC6085@elie.Belkin>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: gitster@pobox.com, pclouds@gmail.com, git@vger.kernel.org,
	Brandon Casey <bcasey@nvidia.com>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jan 22 10:43:31 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TxaOA-0007Yv-5o
	for gcvg-git-2@plane.gmane.org; Tue, 22 Jan 2013 10:43:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752157Ab3AVJnH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 22 Jan 2013 04:43:07 -0500
Received: from mail-vb0-f45.google.com ([209.85.212.45]:63026 "EHLO
	mail-vb0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751718Ab3AVJnG (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 22 Jan 2013 04:43:06 -0500
Received: by mail-vb0-f45.google.com with SMTP id p1so3216291vbi.32
        for <git@vger.kernel.org>; Tue, 22 Jan 2013 01:43:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:x-received:in-reply-to:references:date:message-id
         :subject:from:to:cc:content-type;
        bh=Ao5iJYAfyKT0uXzo3RB/J/f+HRfMT33aBB1+mxuZF1M=;
        b=sya/ulfhxYILqRKqZ75aXETyQjlh5i6ggqD3GrJtpCY3HM031p25pfenMDbbHWtGtI
         Bj8wEc7Rd3pMjP4jdFdYW3tFIHY1F70iQisjaXqP2exYLNFB7IWn4ivJQYknOs07rztF
         EnVzqaDjf1wXS55KyABULxjBIi2fRYTPkdYEp2138kpHxWX1E02kpKNMGd7qs8AuUXqJ
         vbQpVLTXO9qFYYDcbHWkjHHV/vdr5kAokS0IY44zHegzVqj11WvyRXxosAFbKoR4LSJd
         /P2lL9Frym6HzLuqsKZSiURMJDi7bjscx2klrfAwfjss0PucDhnuSoY54DBa582wLj2D
         jKsg==
X-Received: by 10.52.27.174 with SMTP id u14mr19741115vdg.107.1358847785152;
 Tue, 22 Jan 2013 01:43:05 -0800 (PST)
Received: by 10.58.216.1 with HTTP; Tue, 22 Jan 2013 01:43:05 -0800 (PST)
In-Reply-To: <20130122080216.GC6085@elie.Belkin>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/214225>

On Tue, Jan 22, 2013 at 12:02 AM, Jonathan Nieder <jrnieder@gmail.com> wrote:
> Brandon Casey wrote:

>> --- a/t/test-lib-functions.sh
>> +++ b/t/test-lib-functions.sh
>> @@ -135,12 +135,13 @@ test_pause () {
>>       fi
>>  }
>>
>> -# Call test_commit with the arguments "<message> [<file> [<contents>]]"
>> +# Call test_commit with the arguments "<message> [<file> [<contents> [<tag>]]]"
>>  #
>>  # This will commit a file with the given contents and the given commit
>> -# message.  It will also add a tag with <message> as name.
>> +# message.  It will also add a tag with <message> as name unless <tag> is
>> +# given.
>>  #
>> -# Both <file> and <contents> default to <message>.
>> +# <file>, <contents>, and <tag> all default to <message>.
>
> Simpler:
>
>  # This will commit a file with the given contents and the given commit
>  # message and tag the resulting commit with the given tag name.
>  #
>  # <file>, <contents>, and <tag> all default to <message>.

Yes, a nice improvement.

Thanks,
-Brandon
