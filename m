X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: multi-project repos (was Re: Cleaning up git user-interface warts)
Date: Fri, 17 Nov 2006 13:53:00 +0100
Organization: At home
Message-ID: <ejkb8p$rgk$1@sea.gmane.org>
References: <87k61yt1x2.wl%cworth@cworth.org> <455A1137.8030301@shadowen.org> <87hcx1u934.wl%cworth@cworth.org> <Pine.LNX.4.64.0611141518590.2591@xanadu.home> <87bqn9u43s.wl%cworth@cworth.org> <ejdcg5$4fl$1@sea.gmane.org> <Pine.LNX.4.64.0611141633430.2591@xanadu.home> <7vbqn9y6w6.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.64.0611142007010.2591@xanadu.home> <7v3b8ltq7r.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.64.0611142306090.2591@xanadu.home> <Pine.LNX.4.64.0611150950170.3349@woody.osdl.org> <455BBCE9.4050503@xs4all.nl> <Pine.LNX.4.64.0611151908130.3349@woody.osdl.org> <455C412D.1030408@xs4all.nl> <Pine.LNX.4.64.0611160814560.3349@woody.osdl.org> <455C94FA.3050903@xs4all.nl> <Pine.LNX.4.64.0611160904010.3349@woody.osdl.org> <455CA2A8.5010700@xs4all.nl> <Pine.LNX.4.64.0611160958170.3349@woody.osdl.org> <455CF517.9000101@xs4all.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Transfer-Encoding: QUOTED-PRINTABLE
NNTP-Posting-Date: Fri, 17 Nov 2006 12:52:20 +0000 (UTC)
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
X-Injected-Via-Gmane: http://gmane.org/
Original-Lines: 27
Original-X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: host-81-190-24-209.torun.mm.pl
Mail-Copies-To: jnareb@gmail.com
User-Agent: KNode/0.10.2
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/31695>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1Gl3CW-0001iq-5U for gcvg-git@gmane.org; Fri, 17 Nov
 2006 13:52:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S932887AbWKQMwH convert rfc822-to-quoted-printable (ORCPT
 <rfc822;gcvg-git@m.gmane.org>); Fri, 17 Nov 2006 07:52:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932888AbWKQMwH
 (ORCPT <rfc822;git-outgoing>); Fri, 17 Nov 2006 07:52:07 -0500
Received: from main.gmane.org ([80.91.229.2]:51940 "EHLO ciao.gmane.org") by
 vger.kernel.org with ESMTP id S932887AbWKQMwE (ORCPT
 <rfc822;git@vger.kernel.org>); Fri, 17 Nov 2006 07:52:04 -0500
Received: from list by ciao.gmane.org with local (Exim 4.43) id
 1Gl3CI-0001f9-NL for git@vger.kernel.org; Fri, 17 Nov 2006 13:51:58 +0100
Received: from host-81-190-24-209.torun.mm.pl ([81.190.24.209]) by
 main.gmane.org with esmtp (Gmexim 0.1 (Debian)) id 1AlnuQ-0007hv-00 for
 <git@vger.kernel.org>; Fri, 17 Nov 2006 13:51:58 +0100
Received: from jnareb by host-81-190-24-209.torun.mm.pl with local (Gmexim
 0.1 (Debian)) id 1AlnuQ-0007hv-00 for <git@vger.kernel.org>; Fri, 17 Nov 2006
 13:51:58 +0100
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org

Han-Wen Nienhuys wrote:
> Linus Torvalds escreveu:

>>> If I then do=20
>>>
>>> =A0 git --bare fetch git://git.sv.gnu.org/lilypond.git web/master:m=
aster
>>>
>>> it downloads the same stuff again.=20
>>=20
>> Right. So you can either
>> [..]
>> See?
>=20
> No, I don't understand. In the fetch all the objects with their SHA1s
> were already downloaded. I'd expect that the fetch with a refspec
> would simply write a HEAD and a refs/heads/master, and notice that al=
l
> the actual data was already downloaded, and doesn't download it again=
=2E=20

But how git is to know that you have this already downloaded? Git compa=
res
_refs_ on the local and remote side to calculate what needs to be
downloaded. It does not (and should not) send all the objects IDs local
side has.
--=20
Jakub Narebski
Warsaw, Poland
ShadeHawk on #git

