From: Luke Kenneth Casson Leighton <luke.leighton@gmail.com>
Subject: Re: git pack/unpack over bittorrent - works!
Date: Tue, 7 Sep 2010 01:29:25 +0100
Message-ID: <AANLkTimy9vYDACKBZ7JuBosukLdZx6-bRwPqVLEJBRcj@mail.gmail.com>
References: <AANLkTik-w6jWgrt_kwAk2uNGhF_=3tMEpTZs3nyF_zGA@mail.gmail.com>
	<7voccezr7m.fsf@alter.siamese.dyndns.org>
	<20100903183120.GA4887@thunk.org>
	<alpine.LFD.2.00.1009031522590.19366@xanadu.home>
	<AANLkTi=sC3NMNzPRQM5RKwnZQyRq-gq6+7wdiT5LGDrc@mail.gmail.com>
	<AANLkTinoyehduhdHSEm5yGTLvU6C-ViE885yLd63iQU0@mail.gmail.com>
	<4C81A67B.2060400@gmail.com>
	<alpine.LFD.2.00.1009032304560.19366@xanadu.home>
	<4C81DC34.2090800@gmail.com>
	<alpine.LFD.2.00.1009040153280.19366@xanadu.home>
	<AANLkTi=7jUSCNiPf+HfEQuxaf16Jt06--bFE7=Of9wp=@mail.gmail.com>
	<AANLkTik9awEd40s3r-O8t9DwZBh34Z0ozsxMm1QNjNoT@mail.gmail.com>
	<alpine.LFD.2.00.1009042132500.19366@xanadu.home>
	<AANLkTi=YLx6MqbWd_N0geXbuXLdqAUOneGoym75dfthL@mail.gmail.com>
	<alpine.LFD.2.00.1009051820100.19366@xanadu.home>
	<AANLkTi=CEOj40Sj+zegvX+ry8-y6p7UwsyqdtoHB1d-T@mail.gmail.com>
	<alpine.LFD.2.00.1009061025210.19366@xanadu.home>
	<7v8w3etpjr.fsf@alter.siamese.dyndns.org>
	<alpine.LFD.2.00.1009061942150.19366@xanadu.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	Artur Skawina <art.08.09@gmail.com>,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	"Ted Ts'o" <tytso@mit.edu>, git <git@vger.kernel.org>
To: Nicolas Pitre <nico@fluxnic.net>
X-From: git-owner@vger.kernel.org Tue Sep 07 02:29:38 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Osm44-0007kG-TA
	for gcvg-git-2@lo.gmane.org; Tue, 07 Sep 2010 02:29:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754463Ab0IGA3a convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 6 Sep 2010 20:29:30 -0400
Received: from mail-vw0-f46.google.com ([209.85.212.46]:44347 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753541Ab0IGA30 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 6 Sep 2010 20:29:26 -0400
Received: by vws3 with SMTP id 3so3735968vws.19
        for <git@vger.kernel.org>; Mon, 06 Sep 2010 17:29:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=NadKmJZ7QIpxW8tqFKaxlvsO4Hx+0NT8F9i+09764ck=;
        b=bRYLTRPfI/neUk/BnLvvQrlnE1FWAb7maVL64OOHCEtkkagnZEemL6vcl6abQgtSYW
         fKIrgB/DE/ODgRtroDmhO0n+Tp4YqQJSFRKAy8TX8p65xd2/5ATu4kiVSYJax7J++8ix
         wza5lpzyuGfoksMXy6+nJVBoLugBU+GDt9r+8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=o09q0I3jCu5bf6Q9JXU//rps9kTCxamKkCGIkbdu/tcfdwJQwYp9MMmdmOPzb2q8Rk
         9sPXeUTEbg0dnpmt+NweWLVnhO8t68pnBgpJ6a51kmzrZlbfqDJIbI6fp067rqsGbTA/
         sXFyf7Jal+CgBq8KfvwTlfw66h+FVkM5TETxA=
Received: by 10.220.88.224 with SMTP id b32mr494067vcm.217.1283819365804; Mon,
 06 Sep 2010 17:29:25 -0700 (PDT)
Received: by 10.220.75.196 with HTTP; Mon, 6 Sep 2010 17:29:25 -0700 (PDT)
In-Reply-To: <alpine.LFD.2.00.1009061942150.19366@xanadu.home>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/155653>

On Tue, Sep 7, 2010 at 12:57 AM, Nicolas Pitre <nico@fluxnic.net> wrote=
:
> =C2=A0But I think that Luke has enough
> to play with already by only assuming the easy case for now.

 um, yes.

 i only just noticed that bittorrent's multi-file mode has blocking
that doesn't line up with the bloody file beginnings and ends:

| block 0 256k | block 1 256k | block N 11bytes |
|file1 | file2          | file3 | file4               |

this is why cameron dale threw his hands up in horror at bittorrent
when he created debtorrent, but i didn't understand why, fully, as i
thought that he was creating one .torrent per .deb _anyway_ so if he
had it would have been moot.

so i have to do some tests to see if multiple individual torrents can
be added using the BitTornado API to the same server, and redesign the
damn code so that it adds new "files" to be downloaded based on the
previous one completing.

so, the first quotes file quotes to be requested will be the
"rev-list", and the "finished" callback function will result in the
next layer of "files" as .torrents to be requested, and then finally
the files representing the actual "objects" - generated as git
cat-files on the remote end - get added and requested.

so - all event-driven.  eek!  fuun.  about as understandable as nmbd
in samba (*) :)

l.

(*) i can say that because i did its 1st major rewrite ha ha
