From: Jarrad Hope <me@jarradhope.com>
Subject: Re: Tackling Git Limitations with Singular Large Line-seperated
 Plaintext files
Date: Sat, 28 Jun 2014 13:51:07 +0700
Message-ID: <CAJoVafdyFWjnaKbz47n12ykLAn28TSFDxLvbWfT51Rim7SXLsA@mail.gmail.com>
References: <CAJoVafc1LMxmvCiWci3N+AuAZBsABR3Wb3c6c3stw93OJZ7Scw@mail.gmail.com>
	<CAJo=hJtJCy96SRYmOxEpEMoEVcaegv0SCG0_AH2u0=bSrHZi_A@mail.gmail.com>
	<xmqqegya2qgu.fsf@gitster.dls.corp.google.com>
	<CA+55aFx6vFyZvpyQot_3Ym7wsCZ06abjNx_hEKkza-N856jMnw@mail.gmail.com>
	<57F015EB50E54211BF29FE1F6DE05CF4@black>
	<CA+55aFyaQJDq4dvPyS3oLJp57J_zEmqbXA5UxzL8fdgAaHpJOA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Jason Pyeron <jpyeron@pdinc.us>,
	Junio C Hamano <gitster@pobox.com>,
	Shawn Pearce <spearce@spearce.org>, git <git@vger.kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Sat Jun 28 08:51:19 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1X0mTm-0000Sx-Lj
	for gcvg-git-2@plane.gmane.org; Sat, 28 Jun 2014 08:51:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751035AbaF1GvJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 28 Jun 2014 02:51:09 -0400
Received: from mail-vc0-f181.google.com ([209.85.220.181]:54495 "EHLO
	mail-vc0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750759AbaF1GvI (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 28 Jun 2014 02:51:08 -0400
Received: by mail-vc0-f181.google.com with SMTP id il7so5693476vcb.26
        for <git@vger.kernel.org>; Fri, 27 Jun 2014 23:51:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=fWzO66d+yZi4UAj/QCyRuchriROj1v/IH/9C71IrLyA=;
        b=VUeAlH+htgIHdNjYLjFu5ZMtIWmC8YqregLKOvERiO9I05IAiWAl3mNFmRjrSTOaVm
         1tGWWvikOBVv8GI5roP+K9O8NGQl+gR/kS0WHpPnJEmz50AujwNCH1lKOh78qNe85Cb2
         iICrwZgdocZQSNcaOCFSaTjALeVjMwCURnCiUziOwhj+fc7SfpeepGL57xI7xXCSBQhc
         bD3u5866hDRs/q7okTVYOFnTaqTtEdK+AFMXf0fW50VuqKwyyfk1yAM+gm/8Ow9XNgCi
         73+Pc+ykgq1RiSPDYYYUwDMCl68axCGsnphf4YWE3j2RLLEE+u3e+Cd+s368aeRg9Gdc
         n4Iw==
X-Gm-Message-State: ALoCoQnKgb9xye5mMEiT9QrjEsDMrnADOSEryFPgkXABXdPXxffOHpLGpP/5FncNKHYD2fU649d6
X-Received: by 10.58.122.196 with SMTP id lu4mr1301022veb.52.1403938267452;
 Fri, 27 Jun 2014 23:51:07 -0700 (PDT)
Received: by 10.52.255.103 with HTTP; Fri, 27 Jun 2014 23:51:07 -0700 (PDT)
In-Reply-To: <CA+55aFyaQJDq4dvPyS3oLJp57J_zEmqbXA5UxzL8fdgAaHpJOA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/252599>

Thank-you all for replying,

It's just as Jason suggests - Genbank, FASTA & EMBL are more or less
the defacto standards, I suspect FASTA will be phased out because (to
my knowledge) it does not support gene annotation, nevertheless, they
are all text based.

These formats usually insert linebreaks around 80 characters (a
cultural/human readability relic, whatever terminal output they had
the time)

I tried to find a Penguin genome sequence for you, The best I can find
is the complete penguin mitochrondrian dna, as you can see, fairly
small.
http://www.ncbi.nlm.nih.gov/nuccore/558603183?report=fasta
http://www.ncbi.nlm.nih.gov/nuccore/558603183?report=genbank

If you would like to checkout the source for a Human, please see
ftp://ftp.ensembl.org/pub/current_fasta/homo_sapiens/dna/
Don't ask me for a Makefile :) in near future you'll be able to print
sequences of this length, today we're limited to small sequences (such
as bacteria/virus) at ~30cents per basepair

Each chromosome packs quite well ~80MB packed, ~240MB unpacked
However these formats allow you to repesent multiple sequences in one file
ftp://ftp-trace.ncbi.nih.gov/1000genomes/ftp/technical/reference/human_g1k_v37.fasta.gz
<- ~850MB packed

Sidenote, Humans aren't that particulary more complicated than Rice
(in terms of genome size)
http://www.plantgdb.org/XGDB/phplib/download.php?GDB=Os

Other animal sequences - http://www.ensembl.org/index.html

Git is already being used very successfully for SBML, Synthetic
Biology Markup Language, an XML dialect for cell modelling.

I would show an example git repo of some open source cancer treatments
(various oncolytic viruses) I've been working on, unfortunately it's
not finished yet, but you can imagine something the size of penguin
mitochrondrial dna with essentially just text being deleted (gene
deletions) as commits.

I hope that helps - With the advancement of Synthetic and Systems
Biology, I really see these sequences benefiting from git.


On Sat, Jun 28, 2014 at 3:13 AM, Linus Torvalds
<torvalds@linux-foundation.org> wrote:
> On Fri, Jun 27, 2014 at 12:55 PM, Jason Pyeron <jpyeron@pdinc.us> wrote:
>>
>> The issue will be, if we talk about changes other than same length substitutions
>> (e.g. Down's Syndrome where it has an insertion of code) would require one code
>> per line for the diffs to work nicely.
>
> Not my area of expertise, but depending on what you are interested in
> - like protein encoding etc, I really think you don't need to do
> things character-per-character. You might want to break at interesting
> sequences (TATA box, and/or known long repeating sequences).
>
> So you could basically turn the "one long line" representation into
> multiple lines, by just looking for particular known interesting (or
> known particularly *UN*interesting) patterns, and whenever you see the
> pattern you create a new line, describing the pattern ("TATAAA" or
> "run of 128 U"), and then continue on the next line.
>
> Then you diff those "semantically enriched" streams instead of the raw data.
>
> But it probably depends on what you are looking for and at. Sometimes
> you might be looking at individual base pairs. And sometimes maybe you
> want to look at the codons, and consider condons that transcribe to
> the same amino acid to be the same, and not show up as a difference.
> So I could well imagine that you might want to have multiple different
> ways to generate these diffs. No?
>
>                Linus
