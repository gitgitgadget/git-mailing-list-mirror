Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.6 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D38A820A17
	for <e@80x24.org>; Thu, 19 Jan 2017 15:54:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753155AbdASPyr (ORCPT <rfc822;e@80x24.org>);
        Thu, 19 Jan 2017 10:54:47 -0500
Received: from mout.gmx.net ([212.227.15.15]:54571 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753314AbdASPyp (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 19 Jan 2017 10:54:45 -0500
Received: from virtualbox ([37.24.141.236]) by mail.gmx.com (mrgmx001
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0M0y8F-1cGZm63fDT-00v60O; Thu, 19
 Jan 2017 16:54:38 +0100
Date:   Thu, 19 Jan 2017 16:54:36 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     Stephan Beyer <s-beyer@gmx.net>
cc:     Marc Branchaud <marcnarc@xiplink.com>, git <git@vger.kernel.org>
Subject: Re: [RFC] stash --continue
In-Reply-To: <e273c7c8-278a-061c-44fd-4808b53d0475@gmx.net>
Message-ID: <alpine.DEB.2.20.1701191650470.3469@virtualbox>
References: <cd784a4e-ee99-564e-81de-9f7f6cc26c67@gmx.net> <alpine.DEB.2.20.1701161153340.3469@virtualbox> <d5456165-bdf2-e9e7-117f-aeab0ff4b417@xiplink.com> <e273c7c8-278a-061c-44fd-4808b53d0475@gmx.net>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:Y9fLI8J2A/m2hFbdLT+4h/S6bKazHlG64MjY/Fnj6aD1m+018sH
 PlIzfQn5pInDJm6eqax8OqosxXndTvv6UWfUzVQlC0rJ/yPtNyF6uW44yMluECU1b9uHN8w
 lrYkLDoNmd8QXNBQZ7vtAVRbMfGwlNE1NtvAuymLk5cAdUizhO/fM+sXpZ4Ffr/5AjK870j
 WfktQ2AazgsPVs6BvfTmw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:R+S0DqR2qnQ=:ke5FqUzwiJd5duA56YQq3D
 rkMItrM9MGy0PHk9UAG6qFCmphDBUSluebNEuYNeCqXN16jBJXwhcOg8xih9gJnn6Ay4tnY7k
 OqYWP1A1FjygiTj+gqcLFKK/s8UGhyXXpUtwkO9bp4B1SKTStrVReRzMbcDCrIHaYUFsJ4KcP
 ruLZex3mIqJJuFb6XTZ731xjaE4wWFz8n8+JgQ5nINrveGwd3jvIYAb19RJqCyu8kJMhY3gCI
 0trr0J27P/eTfuIBiIN4+lxBXg0TIai9vZ6jVsTs9RmznwTLJckerk5HA99VxFHb2TQnI59aw
 ZHupa/lM6fBawICm3IfIxk7AbjqaN17UFGz7FgYlSiw6J9YIyUTPcS45gE2BpIaAKIjALDXvK
 wWgE0ieLVaJQEeCN0z9AMNIyFq4+aPYjXtImboneYXjOnnoY1xyuk6ecuh6Blos4tfXrfWIT5
 +L0g+iuVmTF9oAd5jgEFvbwhXo+NKypH0bf7qGLKeCM5S8Q7e7VzKYC+bydlbSiaZxBtUAzBB
 GWBz7fp4dE4CkHNXPdhqla63ZHH3xyZpGlqnfkUyw4vFGdskDHi/+hr81ancEJeDGwHx/+/O/
 GYf1+Dc8xArZv6VqK2qmOpkBlNwhf/oLmurZmDvyW6Ty9aXydZi7JYLqLAXcqTxlktqP9+1pk
 4skJ4H24x/qdarH4WeAWXjSv5ObV8yrltOdfFlHR358dbREURzDIPQRZUZiYH9GWIVn3RgLIM
 hcVU+oJwhNbFszVu/SLQEFPGr095GMdCu3cAIDJG0EsQbRZspoGYXrqanvN5jVdV2eoiE908K
 okzo/Zv
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Stephan,

On Wed, 18 Jan 2017, Stephan Beyer wrote:

> PPS: Any opinions about the mentioned "backwards-compatibility" issue
> that people are then forced to finish their commits with "--continue"
> instead of "git reset" or "git commit"?

Maybe you could make it so that "git reset" and "git commit" would still
work as before, and reset the state so that "git stash pop --continue"
could complain that there is nothing to continue?

Similar to how we remove CHERRY_PICK_HEAD during a `git reset --hard`,
maybe?

Ciao,
Johannes
