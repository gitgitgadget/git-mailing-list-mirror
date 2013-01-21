From: Eric Chamberland <Eric.Chamberland@giref.ulaval.ca>
Subject: Re: GIT get corrupted on lustre
Date: Mon, 21 Jan 2013 12:07:10 -0500
Message-ID: <50FD75BE.1030504@giref.ulaval.ca>
References: <50D861EE.6020105@giref.ulaval.ca> <50D870A0.90205@interlinx.bc.ca> <50EC453A.2060306@giref.ulaval.ca> <50EDDF12.3080800@giref.ulaval.ca> <50F7F793.80507@giref.ulaval.ca> <CAGK7Mr4R=OwfWt4Kat75C8YDi3iLTavMLxeoLxkf1-gKhxrucg@mail.gmail.com> <50F8273E.5050803@giref.ulaval.ca> <871B6C10EBEFE342A772D1159D1320853A042AD7@umechphj.easf.csd.disa.mil> <50F829A9.7090606@calculquebec.ca> <871B6C10EBEFE342A772D1159D1320853A044B42@umechphj.easf.csd.disa.mil> <50F98B53.9080109@giref.ulaval.ca> <CABPQNSbJr4dR9mq+kCwGe-RKb9PA7q=SKzbFW+=md_PLzZh=nQ@mail.gmail.com>
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
X-From: git-owner@vger.kernel.org Mon Jan 21 18:07:47 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TxKqX-0001dg-5p
	for gcvg-git-2@plane.gmane.org; Mon, 21 Jan 2013 18:07:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752895Ab3AURHU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 21 Jan 2013 12:07:20 -0500
Received: from serveur.giref.ulaval.ca ([132.203.7.102]:33886 "EHLO
	mailhost.giref.ulaval.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752884Ab3AURHQ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 21 Jan 2013 12:07:16 -0500
Received: from localhost (localhost [127.0.0.1])
	by mailhost.giref.ulaval.ca (Postfix) with ESMTP id 9FA181020A5;
	Mon, 21 Jan 2013 12:07:11 -0500 (EST)
X-Virus-Scanned: amavisd-new at giref.ulaval.ca
Received: from mailhost.giref.ulaval.ca ([127.0.0.1])
	by localhost (mailhost.giref.ulaval.ca [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id MzgMUJCSd0qb; Mon, 21 Jan 2013 12:07:11 -0500 (EST)
Received: from [132.203.7.22] (melkor.giref.ulaval.ca [132.203.7.22])
	by mailhost.giref.ulaval.ca (Postfix) with ESMTP id 0616210191C;
	Mon, 21 Jan 2013 12:07:11 -0500 (EST)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20130105 Thunderbird/17.0.2
In-Reply-To: <CABPQNSbJr4dR9mq+kCwGe-RKb9PA7q=SKzbFW+=md_PLzZh=nQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/214133>

Hi,

It just happened again.  Now I have the "strace -f" output gzipped here:

http://www.giref.ulaval.ca/~ericc/strace-f_git_error.txt.gz

thanks,

Eric

On 01/21/2013 08:29 AM, Erik Faye-Lund wrote:
> On Fri, Jan 18, 2013 at 6:50 PM, Eric Chamberland
> <Eric.Chamberland@giref.ulaval.ca> wrote:
>> Good idea!
>>
>> I did a strace and here is the output with the error:
>>
>> http://www.giref.ulaval.ca/~ericc/strace_git_error.txt
>>
>> Hope it will be insightful!
>
> This trace doesn't seem to contain child-processes, but instead having
> their stderr inlined into the log. Try using "strace -f" instead...
>
