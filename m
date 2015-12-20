From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] commit: ensure correct permissions of the commit
 message
Date: Sun, 20 Dec 2015 15:21:46 +0100 (CET)
Message-ID: <alpine.DEB.2.20.1512201519590.6483@virtualbox>
References: <4aa11f02f4de113bf38152b8815658da42690f43.1450549280.git.johannes.schindelin@gmx.de> <20151220074559.GF30662@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Yaroslav Halchenko <yoh@onerussian.com>,
	=?ISO-8859-15?Q?SZEDER_G=E1bor?= <szeder@ira.uka.de>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sun Dec 20 15:22:22 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aAesO-0006vC-Me
	for gcvg-git-2@plane.gmane.org; Sun, 20 Dec 2015 15:22:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932305AbbLTOWQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 20 Dec 2015 09:22:16 -0500
Received: from mout.gmx.net ([212.227.15.19]:63538 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752489AbbLTOWP (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 20 Dec 2015 09:22:15 -0500
Received: from virtualbox ([37.24.143.185]) by mail.gmx.com (mrgmx002) with
 ESMTPSA (Nemesis) id 0MV5tl-1ZhFKq3Ubd-00YUVl; Sun, 20 Dec 2015 15:21:49
 +0100
X-X-Sender: virtualbox@virtualbox
In-Reply-To: <20151220074559.GF30662@sigill.intra.peff.net>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
X-Provags-ID: V03:K0:9Q+HtPUMxNECQOizMOiQEarJGZrQ1+ky940ppiVEDCp1cK90Z/N
 KiYfpG6Q3MuQ63ijjD5pTzreNVGjqfQ5NYN99VJNeWRjmzMivSocskELgoeJSZFP9WdqKty
 8CZDDz0gXQiuQ3HDNLK0V22qIij5tPiBlwLbRjSi9dgx/u4YQZHMtJMpYT+3zAf1MjFth0X
 DG69ROUCymhJRMQPvQmXA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:UQg9nKzsNTw=:SNMF+QI6gWWDDQYUoXW9hF
 NuPnPNHRcIXWjfziwshn2aM8hv6W57QYfe8mnkmaUBCFtRb4UmT3cZfRUyOhazxUgNcmJfaN0
 fv3MC2W5C4b6LPL3Ja/SNLigqy1VNwTpVWUbqMaRIE+unkb0G3RKr5AxjTbp0kbPoHZ6ofofM
 EaFRWUXDDxv/6zcN3PLsKWS9q3k8Mh6W5W8xUvz9Y1lLwD1vFVvNUCH8thUelZVobYXXSF9hJ
 AcUq2QXsDy7L4ho9BTkfXA1YZP6HdGB//jgbuj5TxZn7/T4kkdkqrZQ3TqFZIMccuv1hR9Jbn
 WXT3XgMhLn1qppCnlfGkVIiuIeoGp+54C2iGLUsSvfZSsphwgOh1u75YlLETHQJjOy0mlqzyP
 v7pRIMFdMsT7a/Dp2KtHxcx7P80o/25dRqvFexp/KLxebBjlzNY2BHE4m9WVwq2LQAxzS37Uw
 e/rMwy0za3bZE7m+RFEdXa085O/4MafahiDoINLVy2YT3KwYw/vHHgUf9vFuYv6DuErd4dqmZ
 jbqMzMdfIGHey5/hBAfyFZcpZqfCICfDukDad7okmsxJLFTA3aQgFE8bgiUHTWitRbs1/9tVc
 DedxZq9/T0w3pkmXfcV9k45mTKEK6zyxoboHPLh8Z9TqosALGAc1j+louQ7dMqFWohyutd6w0
 P+c3cW9oBYS3YsHp3WjV63diXzqQ7IWoeLaSsrGNTosgh8fCSnQyxUx2xTLyLRITP0tz3Uv/3
 ovaMfgF6SGy+dC4hfsneWA/FUtlzBMq9JKBJmV8TCzrxjrfYrbecuP9sC+ncGlzBQ5/YZmRD 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/282768>

Hi Peff,

On Sun, 20 Dec 2015, Jeff King wrote:

> On Sat, Dec 19, 2015 at 07:21:59PM +0100, Johannes Schindelin wrote:
> 
> > It was pointed out by Yaroslav Halchenko that the file containing the
> > commit message had the wrong permissions in a shared setting.
> > 
> > Let's fix that.
> > 
> > Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> 
> I think this is probably a step forward, but I have to wonder how many
> other files are in a similar situation (e.g., git-am state files, etc).

True.

> I think people generally haven't noticed because shared repositories are
> generally about a shared bare rendezvous repo. So refs and objects are
> important, but we don't expect people to commit.
> 
> So I don't have any real problem with this, but I suspect it's just the
> tip of the iceberg. We might want something like:
> 
>   FILE *fopen_shared(const char *path, const char *mode)
>   {
> 	FILE *ret = fopen(path, mode);
> 	if (!ret)
> 		return NULL;
> 	if (adjust_shared_perm(path)) {
> 		fclose(ret);
> 		return NULL;
> 	}
> 	return ret;
>   }
> 
> but of course the hard part is auditing all of the existing fopen()
> calls to see who needs to use it. :)

In principle, I agree, but I have to point out that the
adjust_shared_perm() call must come after the *fclose()* call, to avoid
modifying files to which we currently have open file handles.

Ciao,
Dscho
