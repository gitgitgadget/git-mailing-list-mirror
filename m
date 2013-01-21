From: Eric Chamberland <Eric.Chamberland@giref.ulaval.ca>
Subject: Re: GIT get corrupted on lustre
Date: Mon, 21 Jan 2013 13:28:30 -0500
Message-ID: <50FD88CE.5030508@giref.ulaval.ca>
References: <50D861EE.6020105@giref.ulaval.ca> <50D870A0.90205@interlinx.bc.ca> <50EC453A.2060306@giref.ulaval.ca> <50EDDF12.3080800@giref.ulaval.ca> <50F7F793.80507@giref.ulaval.ca> <CAGK7Mr4R=OwfWt4Kat75C8YDi3iLTavMLxeoLxkf1-gKhxrucg@mail.gmail.com> <50F8273E.5050803@giref.ulaval.ca> <871B6C10EBEFE342A772D1159D1320853A042AD7@umechphj.easf.csd.disa.mil> <50F829A9.7090606@calculquebec.ca> <871B6C10EBEFE342A772D1159D1320853A044B42@umechphj.easf.csd.disa.mil> <50F98B53.9080109@giref.ulaval.ca> <CABPQNSbJr4dR9mq+kCwGe-RKb9PA7q=SKzbFW+=md_PLzZh=nQ@mail.gmail.com> <50FD75BE.1030504@giref.ulaval.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: "Pyeron, Jason J CTR (US)" <jason.j.pyeron.ctr@mail.mil>,
	Maxime Boissonneault <maxime.boissonneault@calculquebec.ca>,
	Philippe Vaucher <philippe.vaucher@gmail.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>,
	=?ISO-8859-1?Q?S=E9bastien_Boisvert?= 
	<sebastien.boisvert@calculquebec.ca>
To: kusmabite@gmail.com
X-From: git-owner@vger.kernel.org Mon Jan 21 19:29:03 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TxM75-0004cD-RW
	for gcvg-git-2@plane.gmane.org; Mon, 21 Jan 2013 19:28:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755429Ab3AUS2c (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 21 Jan 2013 13:28:32 -0500
Received: from serveur.giref.ulaval.ca ([132.203.7.102]:57401 "EHLO
	mailhost.giref.ulaval.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752592Ab3AUS2b (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 21 Jan 2013 13:28:31 -0500
Received: from localhost (localhost [127.0.0.1])
	by mailhost.giref.ulaval.ca (Postfix) with ESMTP id 113ED10202D;
	Mon, 21 Jan 2013 13:28:31 -0500 (EST)
X-Virus-Scanned: amavisd-new at giref.ulaval.ca
Received: from mailhost.giref.ulaval.ca ([127.0.0.1])
	by localhost (mailhost.giref.ulaval.ca [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id fYjJH0hNTE4v; Mon, 21 Jan 2013 13:28:30 -0500 (EST)
Received: from [132.203.7.22] (melkor.giref.ulaval.ca [132.203.7.22])
	by mailhost.giref.ulaval.ca (Postfix) with ESMTP id 7F8A5101961;
	Mon, 21 Jan 2013 13:28:30 -0500 (EST)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20130105 Thunderbird/17.0.2
In-Reply-To: <50FD75BE.1030504@giref.ulaval.ca>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/214134>

On 01/21/2013 12:07 PM, Eric Chamberland wrote:
> Hi,
>
> It just happened again.  Now I have the "strace -f" output gzipped here:
>
> http://www.giref.ulaval.ca/~ericc/strace-f_git_error.txt.gz
>

I added the "strace -f" output when non error occurs...

http://www.giref.ulaval.ca/~ericc/strace-f_git_no_error.txt.gz

a "kdiff3" can show the differences just before the error...

Eric
