From: Richard Hansen <rhansen@bbn.com>
Subject: Re: [PATCH v3 1/5] pull: rename pull.rename to pull.mode
Date: Fri, 11 Oct 2013 20:32:57 -0400
Message-ID: <525898B9.5020904@bbn.com>
References: <1378689796-19305-1-git-send-email-felipe.contreras@gmail.com> <1378689796-19305-2-git-send-email-felipe.contreras@gmail.com> <522E3C6A.3070409@bbn.com> <CAMP44s1OyST3S1HEdS38WPsjq6w9SekuwT4DRUgVvduATox9tw@mail.gmail.com> <20130910022152.GA17154@sigill.intra.peff.net> <CAMP44s1FfQ-1pAK8T1cmiZk4i17HnpvzPwuZrzHiiXSmGzbrRw@mail.gmail.com> <vpqmwnljdmn.fsf@anie.imag.fr> <52589027a4851_5dc4c2be742754f@nysa.mail>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org,
	Andreas Krey <a.krey@gmx.de>,
	John Keeping <john@keeping.me.uk>,
	Philip Oakley <philipoakley@iee.org>,
	"brian m. carlson" <sandals@crustytoothpaste.net>
To: Felipe Contreras <felipe.contreras@gmail.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Sat Oct 12 02:33:23 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VUn91-0004xt-3Q
	for gcvg-git-2@plane.gmane.org; Sat, 12 Oct 2013 02:33:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753957Ab3JLAdP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 11 Oct 2013 20:33:15 -0400
Received: from smtp.bbn.com ([128.33.1.81]:24861 "EHLO smtp.bbn.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753244Ab3JLAdO (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 11 Oct 2013 20:33:14 -0400
Received: from socket.bbn.com ([192.1.120.102]:43604)
	by smtp.bbn.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.77 (FreeBSD))
	(envelope-from <rhansen@bbn.com>)
	id 1VUn8d-0005qp-S8; Fri, 11 Oct 2013 20:32:59 -0400
X-Submitted: to socket.bbn.com (Postfix) with ESMTPSA id B8A053FF1C
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:24.0) Gecko/20100101 Thunderbird/24.0
In-Reply-To: <52589027a4851_5dc4c2be742754f@nysa.mail>
X-Enigmail-Version: 1.5.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/235932>

On 2013-10-11 19:56, Felipe Contreras wrote:
> Matthieu Moy wrote:
>> Felipe Contreras <felipe.contreras@gmail.com> writes:
>>
>>> On Mon, Sep 9, 2013 at 9:21 PM, Jeff King <peff@peff.net> wrote:
>>>> On Mon, Sep 09, 2013 at 05:49:36PM -0500, Felipe Contreras wrote:
>>>>
>>>>>> These deprecation warning messages should be written to stderr, and
>>>>>> should probably be prefixed with "WARNING: ".
>>>>>
>>>>> Is there any deprecation warning that works this way?
>>>>
>>>> The ones in C code typically use warning(), which will prefix with
>>>> "warning:" and write to stderr. They do not use all-caps, though.
>>>>
>>>> Try "git log --grep=deprecate -Swarning" for some examples.
>>>
>>> I'm asking about the ones in shell, because this is a shell script.
>>
>> No user cares whether "git pull" is written in shell. shell Vs C is an
>> implementation detail, stdout Vs stderr is user-visible.
> 
> You are free to go ahead and implement 'warning ()' in git-sh-setup.sh, in the
> meantime no shell script does that, and that's no reason to reject this patch
> series.

Sure, but is is a reason to reroll the patch series.  Maybe it's not a
strong enough reason on its own to reroll, but if you're going to reroll
anyway, this should be fixed.

-Richard
