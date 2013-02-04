From: Eric Chamberland <Eric.Chamberland@giref.ulaval.ca>
Subject: Re: GIT get corrupted on lustre
Date: Mon, 04 Feb 2013 08:58:40 -0500
Message-ID: <510FBE90.6000105@giref.ulaval.ca>
References: <50D861EE.6020105@giref.ulaval.ca> <50D870A0.90205@interlinx.bc.ca> <50EC453A.2060306@giref.ulaval.ca> <50EDDF12.3080800@giref.ulaval.ca> <50F7F793.80507@giref.ulaval.ca> <CAGK7Mr4R=OwfWt4Kat75C8YDi3iLTavMLxeoLxkf1-gKhxrucg@mail.gmail.com> <50F8273E.5050803@giref.ulaval.ca> <871B6C10EBEFE342A772D1159D1320853A042AD7@umechphj.easf.csd.disa.mil> <50F829A9.7090606@calculquebec.ca> <871B6C10EBEFE342A772D1159D1320853A044B42@umechphj.easf.csd.disa.mil> <50F98B53.9080109@giref.ulaval.ca> <CABPQNSbJr4dR9mq+kCwGe-RKb9PA7q=SKzbFW+=md_PLzZh=nQ@mail.gmail.com> <87a9s2o6ri.fsf@pctrast.inf.ethz.ch> <kdk2ss$498$1@ger.gmane.org> <87r4lejpx8.fsf@pctrast.inf.ethz.ch> <50FF051D.5090804@giref.ulaval.ca> <878v7keuh3.fsf@pctrast.inf.ethz.ch> <51002D18.4080201@calculquebec.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Thomas Rast <trast@student.ethz.ch>,
	"Brian J. Murrell" <brian@interlinx.bc.ca>, git@vger.kernel.org,
	kusmabite@gmail.com,
	"Pyeron, Jason J CTR (US)" <jason.j.pyeron.ctr@mail.mil>,
	Maxime Boissonneault <maxime.boissonneault@calculquebec.ca>,
	Philippe Vaucher <philippe.vaucher@gmail.com>
To: =?ISO-8859-1?Q?S=E9bastien_Boisvert?= 
	<sebastien.boisvert@calculquebec.ca>
X-From: git-owner@vger.kernel.org Mon Feb 04 14:59:13 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U2MZh-0003z5-RM
	for gcvg-git-2@plane.gmane.org; Mon, 04 Feb 2013 14:59:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754985Ab3BDN6r convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 4 Feb 2013 08:58:47 -0500
Received: from serveur.giref.ulaval.ca ([132.203.7.102]:36883 "EHLO
	mailhost.giref.ulaval.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754151Ab3BDN6q (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 4 Feb 2013 08:58:46 -0500
Received: from localhost (localhost [127.0.0.1])
	by mailhost.giref.ulaval.ca (Postfix) with ESMTP id AF3391021E5;
	Mon,  4 Feb 2013 08:58:41 -0500 (EST)
X-Virus-Scanned: amavisd-new at giref.ulaval.ca
Received: from mailhost.giref.ulaval.ca ([127.0.0.1])
	by localhost (mailhost.giref.ulaval.ca [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id feZJy70h02LP; Mon,  4 Feb 2013 08:58:41 -0500 (EST)
Received: from [132.203.7.22] (melkor.giref.ulaval.ca [132.203.7.22])
	by mailhost.giref.ulaval.ca (Postfix) with ESMTP id ED99A1021E2;
	Mon,  4 Feb 2013 08:58:40 -0500 (EST)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20130105 Thunderbird/17.0.2
In-Reply-To: <51002D18.4080201@calculquebec.ca>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/215384>

Hi,

On 01/23/2013 01:34 PM, S=E9bastien Boisvert wrote:
> Hello,
>
> Here is a patch (with git format-patch) that removes any timer if
> NO_SETITIMER is set.
>

Even with the patch, I finally got an error... :-/

Here are the log (strace -f) of a clean execution and one with the erro=
r:

http://www.giref.ulaval.ca/~ericc/NO_SETITIMER-patch_bin_git_noerror.tx=
t.gz

http://www.giref.ulaval.ca/~ericc/NO_SETITIMER-patch_bin_git_with_error=
=2Etxt.gz

Eric
