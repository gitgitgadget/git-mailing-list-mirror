From: pinard@iro.umontreal.ca (=?utf-8?Q?Fran=C3=A7ois?= Pinard)
Subject: Re: Slight in error in git-rerere help page
Date: Mon, 27 Jul 2009 22:28:09 -0400
Organization: Linux Private Site
Message-ID: <ygetz0x35ja.fsf@phenix.progiciels-bpi.ca>
References: <ygeocr5blap.fsf@phenix.progiciels-bpi.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jul 28 04:28:21 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MVcQB-00061I-US
	for gcvg-git-2@gmane.org; Tue, 28 Jul 2009 04:28:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751747AbZG1C17 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 27 Jul 2009 22:27:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751356AbZG1C16
	(ORCPT <rfc822;git-outgoing>); Mon, 27 Jul 2009 22:27:58 -0400
Received: from main.gmane.org ([80.91.229.2]:38480 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751229AbZG1C16 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 27 Jul 2009 22:27:58 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1MVcPz-00033h-FZ
	for git@vger.kernel.org; Tue, 28 Jul 2009 02:27:55 +0000
Received: from 206-248-137-202.dsl.teksavvy.com ([206.248.137.202])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 28 Jul 2009 02:27:55 +0000
Received: from pinard by 206-248-137-202.dsl.teksavvy.com with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 28 Jul 2009 02:27:55 +0000
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: 206-248-137-202.dsl.teksavvy.com
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.3 (gnu/linux)
Cancel-Lock: sha1:rPDgliItZAUD1hmuiW3oAIejFt0=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/124206>

pinard@iro.umontreal.ca (Fran=C3=A7ois Pinard) writes:

> Hi, people.  This is for git version 1.6.4.rc3.12.gdf73a
>
> The output of "git help rerere" contains:
>
>    You need to set the configuration variable rerere.enabled to enabl=
e
>    this command.
>
> It seems that that "enable" is not a proper value.  If I used it over=
 a
> small repository, I get:
>
>    22:17:33 0 pinard@phenix:etc $ git config rerere.enabled enable
>    22:17:44 0 pinard@phenix:etc $ git gc
>    Counting objects: 1072, done.
>    Compressing objects: 100% (559/559), done.
>    Writing objects: 100% (1072/1072), done.
>    Total 1072 (delta 460), reused 1072 (delta 460)
>    fatal: bad config value for 'rerere.enabled' in .git/config
>    error: failed to run rerere
>
> Removing the rerere section repairs this last problem.
>
> P.S. - I'm also a bit curious about why rerere is needed for a garbag=
e
> collection.

I now see my mistake, which is one of misreading English.  Sorry for my
noise.  Thanks!

--=20
=46ran=C3=A7ois Pinard   http://pinard.progiciels-bpi.ca
