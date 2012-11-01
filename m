From: Kevin <ikke@ikke.info>
Subject: Re: Wrap commit messages on `git commit -m`
Date: Thu, 1 Nov 2012 22:52:09 +0100
Message-ID: <CAO54GHDRBDyQYvo-g_xEvsQJRgtfbbT-4-kop8hoSK1D37G44w@mail.gmail.com>
References: <CALkWK0kQ+qCsOa87yY4wma279mp+9h+LFv3qCP_qrNdDyGNcsQ@mail.gmail.com>
 <m3a9v170ca.fsf@black.gullik.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git <git@vger.kernel.org>
To: =?UTF-8?Q?Lars_Gullik_Bj=C3=B8nnes?= <larsbj@gullik.org>
X-From: git-owner@vger.kernel.org Thu Nov 01 22:52:47 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TU2gu-0000C1-GM
	for gcvg-git-2@plane.gmane.org; Thu, 01 Nov 2012 22:52:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1762361Ab2KAVwb convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 1 Nov 2012 17:52:31 -0400
Received: from mail-we0-f174.google.com ([74.125.82.174]:62572 "EHLO
	mail-we0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1762334Ab2KAVwa convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 1 Nov 2012 17:52:30 -0400
Received: by mail-we0-f174.google.com with SMTP id t9so1349153wey.19
        for <git@vger.kernel.org>; Thu, 01 Nov 2012 14:52:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:from:date
         :x-google-sender-auth:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=GKpBsSQGo+X6pkOhLoBx1T04eDgEMd6v3HbDF+tf97I=;
        b=Z0e6EoMgBFwtkVM0ZRMDws6c+caBkxSSJtIcDltPYrKWlih7aoI3vJiJrh30ryiWFt
         TyFwHI8BthpmBWEp8prOqOeHV3K6QOdK/trueqg4tfc+6oalgQDCKJPmrlh+PZVnOoCF
         eRD/Mo2oIZmrE4HCstjZCvohW1NFfZf+JfUD3THAloy5t6dt8dZguQEPU9gW0VajdsWq
         KSaTVWG8gUtKe/9xI8oPObKN5Buut8DlSDanEphmz144Qd6SM/fIPm9JeLYyyI0U10oH
         Isn0pYjNkaGz4prL4JUF1LG4eO4iZlqMNXQONYvrYGMmuPYDs8modmNGKy1BB2DFSQIh
         VkDg==
Received: by 10.180.24.193 with SMTP id w1mr3428679wif.22.1351806749604; Thu,
 01 Nov 2012 14:52:29 -0700 (PDT)
Received: by 10.227.29.101 with HTTP; Thu, 1 Nov 2012 14:52:09 -0700 (PDT)
In-Reply-To: <m3a9v170ca.fsf@black.gullik.net>
X-Google-Sender-Auth: QtwEG3mNo3P6urwB6Vc-l3GGcfE
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/208891>

As I see it, the problem is not the possibility to add new lines, but
colleagues being too lazy to add them.

On Thu, Nov 1, 2012 at 5:29 PM, Lars Gullik Bj=C3=B8nnes <larsbj@gullik=
=2Eorg> wrote:
> Ramkumar Ramachandra <artagnon@gmail.com> writes:
>
> | Hi,
>>
> | Some of my colleagues are lazy to fire up an editor and write prope=
r
> | commit messages- they often write one-liners using `git commit -m`.
> | However, that line turns out to be longer than 72 characters, and t=
he
> | resulting `git log` output is ugly.  So, I was wondering if it woul=
d
> | be a good idea to wrap these one-liners to 72 characters
> | automatically.
>
> git commit -m 'foo: fix this problem
>
> This problem is fixed by doing foo,
> bar and baz.
>
> Signed-off-by: me
> '
>
> works.
>
> --
>         Lgb
>
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
