From: Jon Seymour <jon.seymour@gmail.com>
Subject: Re: rebase -p loses amended changes
Date: Sat, 31 Mar 2012 20:39:05 +1100
Message-ID: <CAH3AnrpasFU2bLEZsAXRQu4U+=R_YyW+-yRXDfzy2JQpqf9dNw@mail.gmail.com>
References: <592E2EEC-6CBA-48D6-8D44-34A971DD78EC@gmail.com>
	<CAH3Anrqorf481jw6GdHqOPg9WC0rD-OraOHZ7twWRF4+oJ9X4A@mail.gmail.com>
	<87fwcpun95.fsf@thomas.inf.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "git@vger.kernel.org" <git@vger.kernel.org>, jrobertray@gmail.com
To: Thomas Rast <trast@student.ethz.ch>
X-From: git-owner@vger.kernel.org Sat Mar 31 11:39:14 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SDum9-0004eh-HX
	for gcvg-git-2@plane.gmane.org; Sat, 31 Mar 2012 11:39:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755705Ab2CaJjI convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 31 Mar 2012 05:39:08 -0400
Received: from mail-bk0-f46.google.com ([209.85.214.46]:50042 "EHLO
	mail-bk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755531Ab2CaJjG convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 31 Mar 2012 05:39:06 -0400
Received: by bkcik5 with SMTP id ik5so1254769bkc.19
        for <git@vger.kernel.org>; Sat, 31 Mar 2012 02:39:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=W/YtbaQS3be/zOT0GHJzEo8MclBS7RTyMkPDvpgjruc=;
        b=EuU7I1r38w/5zxTOVoQLcc9J2ZmwGKTdwFhkjoHVq2zomz9fDjsaf8UPpb/NyDKTrC
         aHx2SOWnSeiQZBF1rbHhjfdZ6Aw+zt1D1GRssppCxx7KOj5Ki5SfaiW5Ma/00bv4/6VQ
         2YKVuQJE1eyMcWq/vl8hXSMcM5HLiTaTeLx3Da0FBcAx0jOcHVBF32+iaXcvc91rBwrN
         QswfwpQu5XW3bmvqE+DFb7gGTLVL+k6uxEY7PyR1Oqa3UUV4t84/5oZ+qhIJdr7itp/q
         3Zgh4ioaCm+QWpj2+TmgxMc1H6Wu3L95MmR7a9Pb9N3uh5UHoZBT8e5w6coB2c01qU8h
         5P9g==
Received: by 10.204.155.73 with SMTP id r9mr619130bkw.22.1333186745206; Sat,
 31 Mar 2012 02:39:05 -0700 (PDT)
Received: by 10.204.40.131 with HTTP; Sat, 31 Mar 2012 02:39:05 -0700 (PDT)
In-Reply-To: <87fwcpun95.fsf@thomas.inf.ethz.ch>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/194444>

On Sat, Mar 31, 2012 at 8:35 PM, Thomas Rast <trast@student.ethz.ch> wr=
ote:
> Jon Seymour <jon.seymour@gmail.com> writes:
>
>> On Sat, Mar 31, 2012 at 9:49 AM, Thomas Rast <trast@student.ethz.ch>=
 wrote:
>>
>> I wonder if there are any really good justifications for changing th=
e
>> content, as distinct from the comments of a merge during an amendmen=
t?
>
> Semantic conflicts do not necessarily show up as
> conflicts-to-be-resolved. =C2=A0The canonical example is when you cha=
nge the
> signature of a function on one side of the merge, and introduce new
> callers on the other side. =C2=A0The merge must then patch all new ca=
llers
> too.

=46air enough - I was thinking that you could these with a commit after
the merge, but I can see that's not the right thing to do, from a
correctness point of view.

jon.
