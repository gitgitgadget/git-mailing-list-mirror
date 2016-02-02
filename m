From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] t6302: drop unnecessary GPG requirement
Date: Tue, 2 Feb 2016 08:06:18 +0100 (CET)
Message-ID: <alpine.DEB.2.20.1602020805280.2964@virtualbox>
References: <1454271562-24291-1-git-send-email-sunshine@sunshineco.com> <xmqq4mdtxjxf.fsf@gitster.mtv.corp.google.com> <alpine.DEB.2.20.1602010759480.2964@virtualbox> <xmqq4mdsw949.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: Eric Sunshine <sunshine@sunshineco.com>, git@vger.kernel.org,
	Karthik Nayak <karthik.188@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Feb 02 08:06:55 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aQV34-0004am-5F
	for gcvg-git-2@plane.gmane.org; Tue, 02 Feb 2016 08:06:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753662AbcBBHGq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 2 Feb 2016 02:06:46 -0500
Received: from mout.gmx.net ([212.227.15.19]:55379 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752929AbcBBHGo (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 2 Feb 2016 02:06:44 -0500
Received: from virtualbox ([37.24.143.74]) by mail.gmx.com (mrgmx002) with
 ESMTPSA (Nemesis) id 0MHX4u-1aTntP2PNc-003Kbo; Tue, 02 Feb 2016 08:06:19
 +0100
X-X-Sender: virtualbox@virtualbox
In-Reply-To: <xmqq4mdsw949.fsf@gitster.mtv.corp.google.com>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
X-Provags-ID: V03:K0:g8QrP2tj2fcW/61ky3jW895qqyKVR7GH3M4r3ZvJNOXtu51dyYo
 CiHMBx3G8IlC3UrR66s4Pm36FL6IDq29Jw8A9T3S8uQ8Lf14QN5j6R7X1g96ZuDPA1+2FfF
 p1gPH2utrm4dXeua5ZHpavIOVFedze5rZk+yPBDk843lmbrUmvScmva9chLmuxBOxtAK5Xa
 ftYJ7EolKLJHKm4U38moQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:+AffognbGUc=:E0cJR5Sy5Er3iQR3VODunb
 fhugwE5dXvb5JSs04HrjAutGDqybucDGDXqkG2P/PnF21MMs1/EwwSKkwvyvrBXLo39rLd4IX
 kGcVTLlgvRmy8e8fWDYWC0X6gv3KiEm/yBI0imu5H/I23dLNCDtb+o3jZ8E46xIQ6q5b9jXtx
 H80d/gcMnEnMdR0JVDBJNqG9BQpCOSwLwyEmDNgk593/WIldxkh/t1epiDj1b5Dr21vzcOVFO
 o6PmkIxnTCALsbp84TRngzlNifrD3fooWCtxIOnXi3yBgKyESbwe1LJBLGev85Y8VxnAEN+0R
 jkQyXdQZ1jJDhXYNf5RQkK2xzE6kMmVTHaVU+zS6vJTnGLS5Qp6EV8kPs/eer6RtMeEDTYbnK
 zxE5oF269Bg5XR2aLnFG67wDWSh7xAxV2o178RcxH9gieVdPV9R04r0tZ5V2RbF0dhYqfKl6N
 vuNrmvsCb5l0w45nOkkaY5daz6b7YvP+IBxioGFAPIs69Ne48JNbPrUgBbd1yNqNy8Yz0kRYQ
 YZBoqFXjnxYTgqy5G0dM2CJAw1Lm9/C76AttceqskhDxiR98vEvIBrITK6grKnOL9JQ6UGEnM
 y5rhn/TzqpnwyUi0yqfOBuhrO6AJDdRjXvKK56MMP+UfSSd6YGtpf/WJgGc79StAhjooivL6A
 +y4Zuy3SNeQDFUiSX80e/arW4d95d9yZOuWK7ye+NadWXP3veqP/FwUIjhdqsPNyMPBelJll5
 NQQjjTl5Zdmn1my8yjhEttOENQgIeGSHG8MMDYRJtKxYQrgSPkEbWBIlBYIY06rLXzbFNlaJ 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/285240>

Hi Junio,

On Mon, 1 Feb 2016, Junio C Hamano wrote:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
> 
> > An even easier solution might be to *not* set up the signed tags in the
> > 'setup' part, but only in the respective test case, and delete them right
> > away after said test case?
> 
> After reading your patch, I do not find it an "easier solution", at
> least with the definition of the word "solution" I would use.  It
> stops testing signed or doubly signed tags everywhere, assuming that
> future regressions can ever break only --points-at tests and no
> other tests around signed tags.

True.

> > Something like this (I even tested this with and without the GPG prereq):
> > ...
> > -test_expect_success 'check signed tags with --points-at' '
> > +test_expect_success GPG 'check signed tags with --points-at' '
> > +	git tag -s -m "A signed tag message" signed-tag side &&
> > +	git tag -s -m "Annonated doubly" double-tag signed-tag &&
> > +	test_when_finished git tag -d signed-tag &&
> 
> Interestingly, double-tag is not removed here.

Whooopsie.

I retract the patch in any case ;-)

Ciao,
Dscho
