From: Fabio D'Alfonso <fabio.dalfonso@fabiodalfonso.com>
Subject: Re: t5539 fails on ubuntu for v2.0.0-rc2
Date: Fri, 09 May 2014 18:43:58 +0200
Organization: Fabio D'Alfonso
Message-ID: <536D05CE.6040004@fabiodalfonso.com>
References: <536A8FF8.7080909@fabiodalfonso.com> <xmqqeh056z6q.fsf@gitster.dls.corp.google.com> <20140508041423.GC26630@sigill.intra.peff.net> <536B1DF4.5080109@fabiodalfonso.com> <20140509155945.GG18197@sigill.intra.peff.net>
Reply-To: fabio.dalfonso@fabiodalfonso.com
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri May 09 19:32:22 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wioei-0003em-BM
	for gcvg-git-2@plane.gmane.org; Fri, 09 May 2014 19:32:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757165AbaEIRcQ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 9 May 2014 13:32:16 -0400
Received: from gateway13.websitewelcome.com ([69.56.195.10]:42796 "EHLO
	gateway13.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752977AbaEIRcP (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 9 May 2014 13:32:15 -0400
X-Greylist: delayed 1500 seconds by postgrey-1.27 at vger.kernel.org; Fri, 09 May 2014 13:32:14 EDT
Received: by gateway13.websitewelcome.com (Postfix, from userid 5007)
	id A991F2B9B0EB7; Fri,  9 May 2014 11:44:20 -0500 (CDT)
Received: from gator4050.hostgator.com (gator4050.hostgator.com [192.185.4.61])
	by gateway13.websitewelcome.com (Postfix) with ESMTP id 828FA2B9ACB22
	for <git@vger.kernel.org>; Fri,  9 May 2014 11:44:04 -0500 (CDT)
Received: from [79.9.183.8] (port=20049 helo=[192.168.1.16])
	by gator4050.hostgator.com with esmtpa (Exim 4.82)
	(envelope-from <fabio.dalfonso@fabiodalfonso.com>)
	id 1Wintw-0007S1-NQ; Fri, 09 May 2014 11:44:01 -0500
User-Agent: Mozilla/5.0 (Windows NT 6.1; rv:24.0) Gecko/20100101 Thunderbird/24.5.0
In-Reply-To: <20140509155945.GG18197@sigill.intra.peff.net>
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - gator4050.hostgator.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - fabiodalfonso.com
X-BWhitelist: no
X-Source-IP: 79.9.183.8
X-Exim-ID: 1Wintw-0007S1-NQ
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: ([192.168.1.16]) [79.9.183.8]:20049
X-Source-Auth: fabio.dalfonso@fabiodalfonso.com
X-Email-Count: 1
X-Source-Cap: ZGFsZm9uc287ZGFsZm9uc287Z2F0b3I0MDUwLmhvc3RnYXRvci5jb20=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/248594>

Hi,
yes, the problem comes from root. I made a make test using "git" user i=
n=20
my 12.04 server where there is a gitlab and the test went on for 5539.
I think the 3 could be the better solution.

This is not the place to discuss about the sudo mania, a disease I did=20
not get and hope not to get, but let me share just a short think.=20
Oracle, by product was never made possible to install as a root on=20
linux/unix , while OEL allow the login to made any system / maintenance=
=20
activity.
Such a kind of protection , 'product configuration based' protection,=20
targeted to the needs of the specific usage , always made sense:=20
smoothly configure the system , then stay in the bound of the product.

Why I should manage a possibly try and trash personal desktop (or a 3=20
backups VM) as the NSA server is a mistery I do not want to solve. So=20
this seems a way to give a box to a dumb, to prevent the breakage. Last=
=20
but not least, desktop involve shortcuts and other things, that fly to=20
the root when something is set up by sudo, and I used to put software i=
n=20
/opt for out of the tree stuff (e.g. netbeans or smartgit) , and should=
=20
have to fight with myself to access my setups.
The server setup I made for gitlab has quite sense with its user for th=
e=20
same reason the oracle pretends and in both cases it is a server , you=20
get access to your service not being aware of the mechanics of the back=
end.
In a personal desktop, where confort is the premiere  need, all this=20
seems quite stupid to be forced, also any one could use if he wants.

Sorry for the digression, but it is starting to hurt, generally speakin=
g.


=46abio D'Alfonso
'Enabling Business Through IT'
cell.  +39.348.059.40.22 ***
web: www.fabiodalfonso.com <http://www.fabiodalfonso.com/>
email: fabio.dalfonso@fabiodalfonso.com
<mailto:fabio.dalfonso@fabiodalfonso.com>linkedin:=20
www.linkedin.com/in/fabiodalfonso <http://it.linkedin.com/in/fabiodalfo=
nso>
twitter: www.twitter.com/#!/fabio_dalfonso=20
<http://www.twitter.com/#%21/fabio_dalfonso>

fax: +39.06.874.599.581
BlackBerry=C2=AE Wireless Enabled Address.


          ** Hidden  numbers are automatically rejected by the phone*

On 5/9/2014 5:59 PM, Jeff King wrote:
> On Thu, May 08, 2014 at 08:02:28AM +0200, Fabio D'Alfonso wrote:
>
>> this is the error in httpd error.log
>>
>>   [Wed May 07 20:44:10 2014] [alert] getpwuid: couldn't determine us=
er name
>> from  uid 4294967295, you probably need to modify the User directive
>>   [Wed May 07 20:44:10 2014] [notice] Apache/2.2.17 (Ubuntu) configu=
red --
>> resuming normal operations
>>   [Wed May 07 20:44:10 2014] [alert] getpwuid: couldn't determine us=
er name
>> from  uid 4294967295, you probably need to modify the User directive
>>   [Wed May 07 20:44:10 2014] [alert] getpwuid: couldn't determine us=
er name
>> from  uid 4294967295, you probably need to modify the User directive
>>   [Wed May 07 20:44:10 2014] [alert] getpwuid: couldn't determine us=
er name
>> from  uid 4294967295, you probably need to modify the User directive
>>   [Wed May 07 20:44:10 2014] [alert] getpwuid: couldn't determine us=
er name
>> from  uid 4294967295, you probably need to modify the User directive
>>   [Wed May 07 20:44:11 2014] [alert] Child 12037 returned a Fatal er=
ror...
>> Apache is exiting!
> Hmm.  Some googling turned up a similar case:
>
>    http://www.linuxquestions.org/questions/linux-server-73/apache-won=
%27t-start-because-490312/
>
> It looks like apache is trying to getpwuid (probably as part of doing=
 a
> setuid on its children), failing, and then crashing. I suspect that t=
his
> is related to you running as root, as a non-root apache would not wan=
t
> to (nor be able to) call setuid.
>
> Does running the tests as a non-root user fix it? If so, I think we h=
ave
> a few options in git:
>
>    1. Add a User directive to our httpd.conf. I doubt this is a good
>       idea to do unconditionally, as a non-root apache would probably=
 be
>       unhappy with it.
>
>    2. Add a User directive when we detect that the tests are running =
as
>       root.  This might work, but I'm a bit iffy, as we do not know t=
he
>       appropriate username for the system (e.g., "nobody" versus
>       "www-data" versus something else).
>
>    3. Just disable the http tests when run as root.
>
> I think I'd favor 3. But I'd like to be sure that being root is the
> problem.
>
> -Peff
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
