From: Mark Lodato <lodatom@gmail.com>
Subject: Re: [PATCH/RFC 09/12] docs: use <commit> instead of <commit-ish>
Date: Mon, 15 Mar 2010 21:12:08 -0400
Message-ID: <ca433831003151812l7cc2c1b4hc11c9748ec8ed570@mail.gmail.com>
References: <1268455984-19061-1-git-send-email-lodatom@gmail.com> 
	<1268455984-19061-10-git-send-email-lodatom@gmail.com> <7vwrxf6fnc.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Mar 16 02:12:43 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NrLKm-00018C-SK
	for gcvg-git-2@lo.gmane.org; Tue, 16 Mar 2010 02:12:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965927Ab0CPBMa convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 15 Mar 2010 21:12:30 -0400
Received: from mail-gx0-f217.google.com ([209.85.217.217]:32930 "EHLO
	mail-gx0-f217.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965897Ab0CPBM3 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 15 Mar 2010 21:12:29 -0400
Received: by gxk9 with SMTP id 9so2215335gxk.8
        for <git@vger.kernel.org>; Mon, 15 Mar 2010 18:12:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=41qCR2oZuQlJIVZTKVeXXSQFbZkPtG3VSnapMYT3dgQ=;
        b=x2g8KlCr6q6R5l4kCTDHCsD/UnWgpOhIKfo5QxpjjanS0C7mXI1F9upgvRX7WzZbMU
         ozie3MABeuoCY7kBlf3jkC1QUG5nf//5Bov6W+Io52nFsOC6LGBOcqVXTQhTklzHsYzS
         mN482Y4en9rozmkF3/KmbK/M0MuwJsLo4xjM8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=DdftKKX+M0FXlDqB3Y7WIec7EQD+i8G3V+fAknIKEBGI+WaUG/B75xaigVYzXG1xGZ
         omS9d+GhMYa3CwuXt76FdlqvXFguqiU6LByydjb0wPngZBnJSypOO9zs1ORBIOLZh9/D
         C8Q+wOlsKINcYrQO4kDTUBFCC3LiAxBT6KJZY=
Received: by 10.90.38.24 with SMTP id l24mr1877718agl.92.1268701948423; Mon, 
	15 Mar 2010 18:12:28 -0700 (PDT)
In-Reply-To: <7vwrxf6fnc.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/142288>

On Sat, Mar 13, 2010 at 6:05 PM, Junio C Hamano <gitster@pobox.com> wro=
te:
> Mark Lodato <lodatom@gmail.com> writes:
>
>> There exist no commands that accept a <commit> but not a <commit-ish=
>,
>
> I have one worry about this and [07/12]. =C2=A0The droppage of -ish w=
ould make
> sense from the point of view of describing command line arguments,
> i.e. what you can give to the commands, but it would make it impossib=
le
> for us to talk about places that _only_ tree not arbitrary tree-ish c=
an
> appear. =C2=A0For example, don't we ever talk about something like th=
is?
>
> =C2=A0 =C2=A0A tree object is a sequence of records, each of which de=
scribes the
> =C2=A0 =C2=A0type of entry, object name, and the name of the entry in=
 the tree.
> =C2=A0 =C2=A0When the type is "tree", the object name must name a tre=
e, when the
> =C2=A0 =C2=A0type is "gitlink", the object name must name a commit, .=
=2E.
>
> Other than that small worry, I think the series goes in the right
> direction.

Yes, it would probably be best to leave the -ish terms in the glossary
(which I evidently did by mistake) and in the comments and
documentation, but just not use them as an identifier in angle
brackets.  For example, a command accepting a <tree> would also accept
commits or tags unless otherwise noted, but the term "tree object"
would still only refer to an actual tree object, not a tree-ish.  When
it is unclear, one can use the -ish term, like I just did in that last
sentence.

I'll wait a few days to see if there are any more comments, and then
I'll try fixing up this series.
