From: Eric Chamberland <Eric.Chamberland@giref.ulaval.ca>
Subject: Re: GIT get corrupted on lustre
Date: Tue, 22 Jan 2013 17:46:08 -0500
Message-ID: <50FF16B0.8010206@giref.ulaval.ca>
References: <50D861EE.6020105@giref.ulaval.ca> <50D870A0.90205@interlinx.bc.ca> <50EC453A.2060306@giref.ulaval.ca> <50EDDF12.3080800@giref.ulaval.ca> <50F7F793.80507@giref.ulaval.ca> <CAGK7Mr4R=OwfWt4Kat75C8YDi3iLTavMLxeoLxkf1-gKhxrucg@mail.gmail.com> <50F8273E.5050803@giref.ulaval.ca> <871B6C10EBEFE342A772D1159D1320853A042AD7@umechphj.easf.csd.disa.mil> <50F829A9.7090606@calculquebec.ca> <871B6C10EBEFE342A772D1159D1320853A044B42@umechphj.easf.csd.disa.mil> <50F98B53.9080109@giref.ulaval.ca> <CABPQNSbJr4dR9mq+kCwGe-RKb9PA7q=SKzbFW+=md_PLzZh=nQ@mail.gmail.com> <87a9s2o6ri.fsf@pctrast.inf.ethz.ch> <kdk2ss$498$1@ger.gmane.org> <87r4lejpx8.fsf@pctrast.inf.ethz.ch> <50FF051D.5090804@giref.ulaval.ca> <878v7keuh3.fsf@pctrast.inf.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: "Brian J. Murrell" <brian@interlinx.bc.ca>, git@vger.kernel.org,
	kusmabite@gmail.com,
	"Pyeron, Jason J CTR (US)" <jason.j.pyeron.ctr@mail.mil>,
	Maxime Boissonneault <maxime.boissonneault@calculquebec.ca>,
	Philippe Vaucher <philippe.vaucher@gmail.com>,
	=?ISO-8859-1?Q?S=E9bastien_Boisvert?= 
	<sebastien.boisvert@calculquebec.ca>
To: Thomas Rast <trast@student.ethz.ch>
X-From: git-owner@vger.kernel.org Tue Jan 22 23:46:33 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Txmbw-0002aL-Hp
	for gcvg-git-2@plane.gmane.org; Tue, 22 Jan 2013 23:46:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753371Ab3AVWqM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 22 Jan 2013 17:46:12 -0500
Received: from serveur.giref.ulaval.ca ([132.203.7.102]:47794 "EHLO
	mailhost.giref.ulaval.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752719Ab3AVWqL (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 22 Jan 2013 17:46:11 -0500
Received: from localhost (localhost [127.0.0.1])
	by mailhost.giref.ulaval.ca (Postfix) with ESMTP id 3278F101951;
	Tue, 22 Jan 2013 17:46:10 -0500 (EST)
X-Virus-Scanned: amavisd-new at giref.ulaval.ca
Received: from mailhost.giref.ulaval.ca ([127.0.0.1])
	by localhost (mailhost.giref.ulaval.ca [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id jOXiyAB-y7tM; Tue, 22 Jan 2013 17:46:08 -0500 (EST)
Received: from [132.203.7.22] (melkor.giref.ulaval.ca [132.203.7.22])
	by mailhost.giref.ulaval.ca (Postfix) with ESMTP id ABBFD1019BC;
	Tue, 22 Jan 2013 17:46:08 -0500 (EST)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20130105 Thunderbird/17.0.2
In-Reply-To: <878v7keuh3.fsf@pctrast.inf.ethz.ch>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/214259>

On 01/22/2013 05:14 PM, Thomas Rast wrote:
> Eric Chamberland <Eric.Chamberland@giref.ulaval.ca> writes:
>
>> So, hum, do we have some sort of conclusion?
>>
>> Shall it be a fix for git to get around that lustre "behavior"?
>>
>> If something can be done in git it would be great: it is a *lot*
>> easier to change git than the lustre filesystem software for a cluster
>> in running in production mode... (words from cluster team) :-/
>
> I thought you already established that simply disabling the progress
> display is a sufficient workaround?  If that doesn't help, you can try
> patching out all use of SIGALRM within git.
>

I tried that solution after Brian told me to try it, but it didn't 
solved the problem for me! :-(

> Other than that I agree with Junio, from what we've seen so far, Lustre
> returns EINTR on all sorts of calls that simply aren't allowed to do so.
>

Ok, so now the "good" move would be to have all this reported to lustre 
development team?  Brian, have you seen anything new from what you have 
already reported?  I have to admit that I am not a fs expert...

And I also agree with Junio point of view: The problem may impact 
mission critical applications....

Eric
