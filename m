From: Harry Johnson <hjohnson@viasic.com>
Subject: Re: Permissions and authorisations in git repository
Date: Fri, 28 Jan 2011 12:01:03 -0500
Message-ID: <AANLkTi=W2Ni=0=hBw5d-2QkQz5tRaMeTLScRYOZhi=BQ@mail.gmail.com>
References: <10431381.57687.1296214887819.JavaMail.trustmail@mail1.terreactive.ch>
	<4D42AEB9.3020008@terreactive.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Victor Engmark <victor.engmark@terreactive.ch>
X-From: git-owner@vger.kernel.org Fri Jan 28 18:01:13 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PirhA-0007Zy-Rq
	for gcvg-git-2@lo.gmane.org; Fri, 28 Jan 2011 18:01:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755303Ab1A1RBG convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 28 Jan 2011 12:01:06 -0500
Received: from mail-wy0-f174.google.com ([74.125.82.174]:50797 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754838Ab1A1RBF convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 28 Jan 2011 12:01:05 -0500
Received: by wyb28 with SMTP id 28so3405463wyb.19
        for <git@vger.kernel.org>; Fri, 28 Jan 2011 09:01:04 -0800 (PST)
Received: by 10.216.184.66 with SMTP id r44mr3257754wem.110.1296234063959;
 Fri, 28 Jan 2011 09:01:03 -0800 (PST)
Received: by 10.216.241.204 with HTTP; Fri, 28 Jan 2011 09:01:03 -0800 (PST)
In-Reply-To: <4D42AEB9.3020008@terreactive.ch>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/165627>

Git is independent of access control mechanisms to some degree,
however, if you use ssh and share a repository with other users you
will want to look into the core.sharedRepository config setting. Took
me a while to discover this.

Check 'git help config' and search for shared for the details.

HTH,
-Harry

On Fri, Jan 28, 2011 at 6:55 AM, Victor Engmark
<victor.engmark@terreactive.ch> wrote:
> On 01/28/2011 12:41 PM, vikram2rhyme wrote:
>>
>> Hello friends
>> I am wondering if there are any permission and authorization control=
 over
>> git
>> repository. I have gone through git manual but there is no discussio=
n on
>> it.
>> On the internet i searched but hardy i found anything. Please help m=
e if
>> there
>> is any permission control in distributed environment in git reposito=
ry
>
> Git is independent of access control mechanisms - You can use whateve=
r you
> want. For example, you could use the filesystem read/write permission=
s on a
> directory to control local access, or SSH permissions to allow remote
> access. See for example GitHub, which uses different protocols for di=
fferent
> levels of access.
>
> HTH,
> --
> Victor Engmark
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
>
